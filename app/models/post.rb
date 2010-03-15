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

  belongs_to :user
end
