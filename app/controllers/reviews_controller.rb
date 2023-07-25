class ReviewsController < ApplicationController
  before_action :set_movie

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user # Associate the review with the current user

    if @review.save
      redirect_back(fallback_location: @movie)
    else
      render 'movies/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end