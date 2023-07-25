require 'rails_helper'

RSpec.describe Movie, type: :model do
  include FactoryBot::Syntax::Methods

  it 'has a valid factory' do
    movie = create(:movie, :with_random_poster_or_url)
    expect(movie).to be_valid
  end

  context "validations" do
    it "is valid with a title and release_date" do
      movie = build(:movie, :with_random_poster_or_url)
      expect(movie).to be_valid
    end

    it "is invalid without a title" do
      movie = build(:movie, title: nil)
      expect(movie).not_to be_valid
      expect(movie.errors[:title]).to include("can't be blank")
    end

    it "is invalid with a duplicate title" do
        create(:movie, title: "Sample Movie", poster: nil, poster_url: :with_random_poster_url)
        movie = build(:movie, title: "Sample Movie", poster: nil, poster_url: :with_random_poster_url)
        expect(movie).not_to be_valid
        expect(movie.errors[:title]).to include("has already been taken")
    end

    it "is invalid without a release_date" do
      movie = build(:movie, release_date: nil)
      expect(movie).not_to be_valid
      expect(movie.errors[:release_date]).to include("can't be blank")
    end
  end

  context "associations" do
    # Test associations here, if needed
  end

  context "custom validation" do
    it "is invalid when both poster and poster_url are present" do
      movie = build(:movie, :with_random_poster, :with_random_poster_url)
      expect(movie).not_to be_valid
      expect(movie.errors[:base]).to include("You can only provide either an uploaded image or an image URL, not both.")
    end

    it "is invalid when both poster and poster_url are blank" do
      movie = build(:movie, poster: nil, poster_url: nil)
      expect(movie).not_to be_valid
      expect(movie.errors[:base]).to include("Please provide either an uploaded image or an image URL.")
    end

    it "is valid when only poster is present" do
      movie = build(:movie, :with_random_poster_or_url, has_poster: true)
      expect(movie).to be_valid
    end

    it "is valid when only poster_url is present" do
      movie = build(:movie, :with_random_poster_or_url, has_poster: false)
      expect(movie).to be_valid
    end
  end
end
