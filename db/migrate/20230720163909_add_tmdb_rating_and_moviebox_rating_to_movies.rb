class AddTmdbRatingAndMovieboxRatingToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :tmdb_rating, :decimal
    add_column :movies, :moviebox_rating, :decimal
  end
end
