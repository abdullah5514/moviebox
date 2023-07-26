# app/models/review.rb
class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  
  validates :rating, presence: true, inclusion: { in: 1..5 }

  after_commit :update_moviebox_review 
   # Validate that each user can only have one review for a specific movie
  validates :user_id, uniqueness: { scope: :movie_id, message: "You can only add one review per movie." }


  def update_moviebox_review
    average_rating = (movie.reviews.sum(:rating) * 2.0 / movie.reviews.count).round(2)
    movie.update(moviebox_rating: average_rating ||= 0)
  end
end
