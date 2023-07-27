module CommonResponses
  extend ActiveSupport::Concern

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


  def movie_params_from_tmdb
    {
      title: params[:title],
      description: params['overview'],
      release_date: params['release_date'],
      poster_url: "https://image.tmdb.org/t/p/w500#{params['poster_path']}",
      tmdb_rating: params['vote_average'],
      trailer_url: params[:trailer_url],
      tmdb_id: params['tmdb_id']
    }
  end
end