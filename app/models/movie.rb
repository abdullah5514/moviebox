# app/models/movie.rb
class Movie < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy

  belongs_to :mov, :class_name => 'Movie'

  validates :title, presence: true
  validates :release_date, presence: true



  def self.search(search)
    if search
      where("title LIKE ?", "%#{search}%")
    else
      all
    end
  end

  def self.check(owner=nil, asdf=nil)
    binding.break
    self.new({title: 'asdf', description: 'asdf'})
    puts('asdfasdfasdfasdf')
  end

  def check
    binding.break

    asfd(asdf)
    self.class.mov.check(123)
  end

  def check(asdf= 'asdf')
    asdf('asdf')
    binding.break
  end

  def  asdf
  end


  alias_method :parent, :check
  alias_method :check, :parent

end
