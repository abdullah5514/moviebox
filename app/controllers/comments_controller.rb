class CommentsController < ApplicationController
  before_action :set_movie

  def create
    @comment = @movie.comments.new(comment_params)
    
    @comment.user = current_user # Associate the comment with the current user

    if @comment.save
      redirect_to @movie, notice: 'Comment was successfully added.'
    else
      render 'movies/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end