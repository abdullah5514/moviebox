# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  
  validates :content, presence: true
end
