class MoviesController < ApplicationController
  def index
    # @movies = Movie.all
    # @movies = Movie.paginate(page: params[:page], per_page: 10)
    # @movies = Movie.search(params[:search]).paginate(page: params[:page], per_page: 10)
    @movies = Movie.order(params[:sort]).paginate(page: params[:page], per_page: 10)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: 'Movie was successfully created.'
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, notice: 'Movie was successfully deleted.'
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :release_date, :description)
  end
end