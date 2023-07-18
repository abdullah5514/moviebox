class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.date :release_date
      t.text :description

      t.timestamps
    end
  end
end
