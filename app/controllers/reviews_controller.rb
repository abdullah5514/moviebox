class ReviewsController < ApplicationController
  before_action :set_movie

  def create
    @review = @movie.reviews.new(review_params)
    if @review.save
      redirect_to @movie, notice: 'Review was successfully added.'
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