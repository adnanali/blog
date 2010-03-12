# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_blog_session',
  :secret => '0c217808a34905336cd7dff54023c6c706a36145fd405a4b8f8615d8d17fa223fac94e8f45dea7a1a53bafcc5dff446433a956c37f4059c04d10fc1f923667dc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
