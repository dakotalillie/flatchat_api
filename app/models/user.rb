class User < ApplicationRecord
  has_many :user_conversations
  has_many :conversations, through: :user_conversations
  has_many :messages
  has_secure_password
end
