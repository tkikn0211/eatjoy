class AddIsDeletedFromUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_deleted, :boolean, default: true, null: false
  end
end
