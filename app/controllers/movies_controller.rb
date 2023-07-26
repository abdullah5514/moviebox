class MoviesController < ApplicationController
  include CommonResponses

  def index
    @movies = Movie.page(params[:page]).per(10)
    @tmdb_movies = Tmdb::MovieService.new(params[:tmdb_page]).discover_movies 
  end

  def show
    @movie = Movie.find(params[:id])
    Tmdb::MovieService.new(1).fetch_movie_from_api(@movie) if @movie.tmdb_id.present?
  end

  def new
    if params.present?
      @movie = Movie.new(movie_params_from_tmdb)
    else
      @movie = Movie.new
    end
  end

  def create
    @movie = current_user.movies.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: 'Movie was successfully created.'
    else
      render :new
    end
  end

  def search
    response = Youtube::Search.new(params[:query]).search_api
    if response.status_code != 200
      render json: response
    else
      render json: {related_movies: load_response_result(response)}
    end
  end

  def tmdb_show
    @movie = Movie.new(tmdb_params)
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
    params.require(:movie).permit(:title, :release_date, :description, :poster, :trailer, :poster_url, :tmdb_rating, :moviebox_rating, :trailer_url, :tmdb_id)
  end

  def tmdb_params
    {title: params[:title], description: params['overview'], release_date: params['release_date'], poster_url: "https://image.tmdb.org/t/p/w500#{params['poster_path']}", tmdb_rating: params['vote_average'], trailer_url: params[:trailer_url], tmdb_id: params['id']}
  end
end