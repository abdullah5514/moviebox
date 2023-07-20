# app/models/review.rb
class Review < ApplicationRecord
  belongs_to :movie

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :content, presence: true
end
