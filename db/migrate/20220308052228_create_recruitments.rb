class CreateRecruitments < ActiveRecord::Migration[6.1]
  def change
    create_table :recruitments do |t|
      
      t.integer :user_id
      t.integer :genre_id
      t.integer :title
      t.string :store_name
      t.string :store_address
      t.string :store_image_id
      t.text :body
      
      t.timestamps
    end
  end
end
