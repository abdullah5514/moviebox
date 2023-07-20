# app/services/movie_service.rb
class MovieService
    include HTTParty
    base_uri 'https://api.themoviedb.org/3'
  
    def initialize(api_key)
      @api_key = api_key
    end
  
    def discover_movies
      options = {
        query: {
          include_adult: false,
          include_video: false,
          language: 'en-US',
          page: 1,
          sort_by: 'popularity.desc'
        },
        headers: {
          'Authorization' => "Bearer #{@api_key}",
          'accept' => 'application/json'
        }
      }
  
      response = self.class.get('/discover/movie', options)
      if response.success?
        response['results']
      else
        raise "Failed to fetch movies: #{response.code} - #{response.message}"
      end
    end
  end
  