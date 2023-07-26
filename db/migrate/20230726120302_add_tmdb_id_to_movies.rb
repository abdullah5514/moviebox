class AddTmdbIdToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :tmdb_id, :integer
  end
end
