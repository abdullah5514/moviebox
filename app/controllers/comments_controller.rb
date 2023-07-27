class CommentsController < ApplicationController
  before_action :set_movie

  # create a comment on a movie by a specific user
  def create
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.build(comment_params)
    @comment.user = current_user # Associate the comment with the current user

    if @comment.save
      respond_to do |format|
        format.html { redirect_to @movie, notice: I18n.t('comments.created') }
        # for turbo stream
        format.turbo_stream { render turbo_stream: turbo_stream.append('comments-list', partial: 'comments/comment', locals: { comment: @comment }) }
      end
    else
      flash.now[:error] = @review.errors.full_messages.to_sentence
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