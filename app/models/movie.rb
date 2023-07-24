# app/models/movie.rb
class Movie < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_one_attached :poster
  has_one_attached :trailer

  validates :title, presence: true, uniqueness: true
  validates :release_date, presence: true


  validate :validate_poster_or_poster_url_presence
  private

  def validate_poster_or_poster_url_presence
    if poster.present? && poster_url.present?
      errors.add(:base, "You can only provide either an uploaded image or an image URL, not both.")
    elsif poster.blank? && poster_url.blank?
      errors.add(:base, "Please provide either an uploaded image or an image URL.")
    end
  end
end
