
module Youtube
  class Search
    require 'google/apis/youtube_v3'
    attr_reader :youtube_env, :youtube

    def initialize(params)
      @youtube_env = Rails.application.credentials.try(:youtube)
      @youtube = Google::Apis::YoutubeV3::YouTubeService.new
      @query = params
    end

    def search_api
      search_api_response
    end

    private

    def search_api_response
      youtube.key = youtube_env.api_key
      response = youtube.list_searches('snippet', q: @query, max_results: 10)
    rescue StandardError => e
      puts( 'Something went wrong here -> ', e.message )
      e
    end
  end
end
