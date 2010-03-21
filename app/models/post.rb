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
    return if not slug.blank?
    Rails.logger.info "make_slug: slug is not blank: #{slug}"
    if title.blank?
      slug = id
      Rails.logger.info "make_slug: title is blank #{slug}"
      return
    end
    self.slug = title.downcase.gsub(/[^a-z0-9]/,'-').squeeze('-').gsub(/^\-|\-$/,'')
    Rails.logger.info "make_slug: title is blank #{slug}"
  end
end
