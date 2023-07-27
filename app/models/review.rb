# app/models/review.rb
class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :content, presence: true
  validate :one_review_per_movie_per_user

  after_commit :update_moviebox_review 

  # update the ratings
  def update_moviebox_review
    average_rating = (movie.reviews.sum(:rating) * 2.0 / movie.reviews.count).round(2)
    movie.update(moviebox_rating: average_rating ||= 0)
  end

  # validation to only allow one review per movie
  def one_review_per_movie_per_user
    existing_review = Review.find_by(user_id: user_id, movie_id: movie_id)
    errors.add(:base, I18n.t('errors.one_review')) if existing_review
  end
end
