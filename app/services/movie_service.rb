# app/services/movie_service.rb
class MovieService
    include HTTParty
    base_uri 'https://api.themoviedb.org/3'
  
    def initialize
      @api_key = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MzRiMGQzNTgyMmQyMjJlNWM3ZWNjMTE1ZTczZjU4OCIsInN1YiI6IjY0YjgwMWQ0ZmRjMTQ2MDBlM2Q4NmZjMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._YD0ZuYshtI2rf0aqzzUB66WJJY_qyM-zlDZmb_Ggh8'
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
    def fetch_movie_from_api()
      options = {
        headers: {
          'Accept-Language' => 'en-US,en;q=0.9',
          'Authorization' => "Bearer #{@api_key}",
          'accept' => 'application/json'
        }
      }
      response = self.class.get("/movie/509635", options)
      if response.success?
        response['results']
      else
        raise "Failed to fetch movies: #{response.code} - #{response.message}"
      end
    end
  end
  