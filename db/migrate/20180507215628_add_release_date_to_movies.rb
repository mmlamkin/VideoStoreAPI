class AddReleaseDateToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :release_date, :string
  end
end