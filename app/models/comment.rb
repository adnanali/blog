class Comment
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

  key :post_id, ObjectId, :required => true
  key :user_id, ObjectId
  key :author, String, :required => true
  key :email, String, :required => true
  key :url, String
  key :ip, String
  key :approved, String
  key :comment_user_id, String
  key :body, String, :required => true

  belongs_to :post, :class_name => "Post"
  belongs_to :user, :class_name => "User"
end
