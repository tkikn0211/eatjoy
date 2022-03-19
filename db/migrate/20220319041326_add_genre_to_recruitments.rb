class AddGenreToRecruitments < ActiveRecord::Migration[6.1]
  def change
    add_column :recruitments, :genre, :string
  end
end
