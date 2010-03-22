class Comment
  include MongoMapper::Document 

  before_create :check_for_spam

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

  key :post_id, ObjectId, :required => true
  key :user_id, ObjectId
  key :author, String, :required => true
  key :email, String, :required => true
  key :url, String
  key :ip, String
  key :referrer, String
  key :user_agent, String
  key :approved, String, :default => "yes"
  key :comment_user_id, String
  key :body, String, :required => true

  belongs_to :post, :class_name => "Post"
  belongs_to :user, :class_name => "User"

  def request=(request)
    self.ip = request.remote_ip
    self.referrer = request.env['HTTP_REFERER']
    self.user_agent = request.env['HTTP_USER_AGENT']
  end

  def check_for_spam
    self.approved = Akismetor.spam?(akismet_attributes) ? "yes" : "spam"
    true
  end

  def akismet_attributes
    {
      :key                  => 'bd92255f3379',
      :blog                 => 'http://test.jaaduhai.com',
      :user_ip              => ip,
      :user_agent           => user_agent,
      :comment_author       => author,
      :comment_author_email => email,
      :comment_author_url   => url,
      :comment_content      => body
    }
  end

  def mark_as_spam!
    update_attributes({:approved => "spam"})
    Akismetor.submit_spam(akismet_attributes)
  end

  def mark_as_ham!
    update_attributes({:approved => "yes"})
    Akismetor.submit_ham(akismet_attributes)
  end
end
