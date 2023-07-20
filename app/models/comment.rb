# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :rep, :class_name => 'Comment'

  validates :content, presence: true
end
