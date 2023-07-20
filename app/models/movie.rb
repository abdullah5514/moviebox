# app/models/movie.rb
class Movie < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :release_date, presence: true



  def self.search(search)
    if search
      where("title LIKE ?", "%#{search}%")
    else
      all
    end
  end
end
