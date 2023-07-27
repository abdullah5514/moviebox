# app/services/movie_service.rb
module Tmdb 
  class MovieService
    include HTTParty
    base_uri 'https://api.themoviedb.org/3'
  
    def initialize(page)
      @page = page
      @tmdb = Rails.application.credentials.try(:tmdb)
    end
  
    def discover_movies
      response = self.class.get('/discover/movie', options)
      if response.success?
        response
      else
        raise "Failed to fetch movies: #{response.code} - #{response.message}"
      end
    end
    
    def fetch_movie_from_api(movie)
      options = { headers: headers }
      response = self.class.get("/movie/#{movie.tmdb_id}", options)
      if response.success?
        movie.update(tmdb_rating: response['vote_average'].round(2))
      else
        raise "Failed to fetch movies: #{response.code} - #{response.message}"
      end
    end

    private

    def query
      {
        include_adult: false,
        include_video: false,
        language: 'en-US',
        page: @page,
        sort_by: 'popularity.desc'
      }
    end

    def headers
      {
        'Authorization' => "Bearer #{@tmdb.api_key}",
        'accept' => 'application/json'
      }
    end

    def options
      {
        query: query,
        headers: headers
      }
    end
  end
end
