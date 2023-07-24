class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @tmdb_movies = MovieService.new.discover_movies
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    if params.present?
      @movie = Movie.new(tmdb_params)
    else
      @movie = Movie.new()
    end
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: 'Movie was successfully created.'
    else
      render :new
    end
  end

  def load_response_result(response_without_filter)
    response = response_without_filter.to_h[:items]
    response.map do |item|
      snippet = item[:snippet]
      {
        kind: item[:kind],
        video_id: item[:id],
        channel_id: snippet[:channel_id],
        channel_title: snippet[:channel_title],
        description: snippet[:description],
        created_at: snippet[:published_at],
        thumbnail_url: snippet.dig(:thumbnails, :high, :url)
      }
    end
  end

  def search
    response = YoutubeApi.new(params[:query]).search_api
    render json: {related_movies: load_response_result(response)}
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
    params.require(:movie).permit(:title, :release_date, :description, :poster, :trailer, :poster_url, :tmdb_rating, :moviebox_rating, :trailer_url)
  end

  def tmdb_params
    {title: params[:title], description: params['overview'], release_date: params['release_date'], poster_url: "https://image.tmdb.org/t/p/w500/#{params['poster_path']}", tmdb_rating: params['vote_average'], trailer_url: params[:trailer_url]}
  end
end