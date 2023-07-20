class YoutubeApi
    include YoutubeAuthentication
    attr_reader :youtube_env, :youtube

    def initialize(params)
      @youtube_env = Rails.application.credentials.try(:youtube)
      @youtube = Google::Apis::YoutubeV3::YouTubeService.new
      @params = params
    end

    def search_api
      search_api_response
    end

    private

    def search_api_response
      search_query = @params[:search]
      max_results = 20
      youtube.key = 'AIzaSyBOFBRGlgWZ4Fimr-fzGkGieCYYNCzMR9o'
      youtube.list_searches('snippet', q: search_query, max_results: max_results)
    rescue StandardError => e
      error_handling(e)
    end
  end