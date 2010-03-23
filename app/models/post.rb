class Post
  include MongoMapper::Document 

  timestamps!
  
  # Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  # validates_presence_of :attribute
 
  # Assocations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  # belongs_to :model
  # many :model
  # one :model
  
  # Callbacks ::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
  # before_craete :your_model_method
  # after_create :your_model_method
  # before_upate :your_model_method
  
  key :user_id, ObjectId
  key :title, String
  key :slug, String
  key :post_type, String, :default => "post"
  key :content, Hash
  key :status, String, :default => "draft"
  key :accept_comment, String, :default => "yes"
  key :publish_date, Time
  key :tags, Array
  key :categories, Array
  key :comment_count, Integer, :default => 0

  belongs_to :user
  many :comments, :class_name => "Comment"

  before_validation :make_slug, :set_publish

  def set_publish
    if status == "publish" and publish_date.blank?
      self.publish_date = Time.now
    end  
  end

  def make_slug
    if self.title.blank? and self.slug.blank?
      self.slug = id
      return
    end
    slug_start = self.slug.blank? ? self.title : self.slug
    suggested_slug = slug_attempt = slug_start.downcase.gsub(/[^a-z0-9]/,'-').squeeze('-').gsub(/^\-|\-$/,'')

    count = 1
    slug_unique = false
    while !slug_unique do
      slug_attempt = "#{suggested_slug}-#{count}" if count > 1
      slug_post = Post.first(:post_type => post_type, :slug => slug_attempt)
      slug_unique = slug_post == nil ? true : slug_post.id == id
      count += 1
    end

    self.slug = slug_attempt
  end

  def approved_comments
    comments.all(:approved => "yes", :order => "created_at") || []
  end
end
