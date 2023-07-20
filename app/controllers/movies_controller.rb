class MoviesController < ApplicationController
  def index
    # @movies = Movie.all
    # @movies = Movie.paginate(page: params[:page], per_page: 10)
    # @movies = Movie.search(params[:search]).paginate(page: params[:page], per_page: 10)
    @movies = Movie.order(params[:sort]).paginate(page: params[:page], per_page: 10)
    @movies = Movie.all
    api_key ='eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MzRiMGQzNTgyMmQyMjJlNWM3ZWNjMTE1ZTczZjU4OCIsInN1YiI6IjY0YjgwMWQ0ZmRjMTQ2MDBlM2Q4NmZjMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._YD0ZuYshtI2rf0aqzzUB66WJJY_qyM-zlDZmb_Ggh8' # Replace with your actual API key
    movie_service = MovieService.new(api_key).discover_movies
    puts movie_service
    # @movies = movie_service.discover_movies
    # rescue StandardError => e
    #   flash[:alert] = "Error fetching movies: #{e.message}"
    #   @movies = [] # Handle the error case by showing an empty array of movies
    # end 
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