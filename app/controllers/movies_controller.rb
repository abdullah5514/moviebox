class MoviesController < ApplicationController
  include CommonResponses

  # show movies from local db and from TMDB
  def index
    @movies = Movie.order(created_at: :desc).page(params[:page]).per(10)
    @tmdb_movies = Tmdb::MovieService.new(params[:tmdb_page]).discover_movies 
  end

  # show movie. If from TMDB then it update the ratings first by
  # loading the movie again from tmdb through Tmdb::MovieService
  def show
    @movie = Movie.find(params[:id])
    Tmdb::MovieService.new(1).fetch_movie_from_api(@movie) if @movie.tmdb_id.present?
  end

  def new
    if params[:title].present?
      @movie = Movie.new(tmdb_url_params)
    else
      @movie = Movie.new
    end
  end

  def create
    @movie = current_user.movies.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: I18n.t('movies.created')
    else
      flash[:error] = @movie.errors.full_messages.to_sentence
      redirect_back(fallback_location: @movie)
    end
  end

  # Search query on Youtube and show results so it can be used to add trailer.
  def search
    response = Youtube::Search.new(params[:query]).search_api
    render json: {related_movies: load_response_result(response)}
  end

  # Show TMDB movie action
  def tmdb_show
    @movie = Movie.new(tmdb_params)
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to @movie, notice: I18n.t('movies.updated')
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, notice: I18n.t('movies.deleted')
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :release_date, :description, :poster, :trailer, :poster_url, :tmdb_rating, :moviebox_rating, :trailer_url, :tmdb_id)
  end

  # params used on show page
  def tmdb_params
    {title: params[:title], description: params['overview'], release_date: params['release_date'], poster_url: "https://image.tmdb.org/t/p/w500#{params['poster_path']}", tmdb_rating: params['vote_average'], trailer_url: params[:trailer_url], tmdb_id: params['id']}
  end

  # params used on new page
  def tmdb_url_params
    {title: params[:title], description: params['overview'], release_date: params['release_date'], poster_url: params['poster_url'] || "https://image.tmdb.org/t/p/w500#{params['poster_path']}", tmdb_rating: params['vote_average'], trailer_url: params[:trailer_url], tmdb_id: params['id']}
  end
end