# app/models/movie.rb
class Movie < ApplicationRecord
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_one_attached :poster


  validates :title, presence: true, uniqueness: true
  validates :release_date, presence: true
  validate :validate_poster_or_poster_url_presence

  private

  # validates if poster or poster url is provided and not both are provided together
  def validate_poster_or_poster_url_presence
    if poster.present? && poster_url.present?
      errors.add(:base, I18n.t('errors.poster_url_both_provided'))
    elsif poster.blank? && poster_url.blank?
      errors.add(:base, I18n.t('errors.poster_urls_present'))
    end
  end
end
