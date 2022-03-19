class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      
      t.integer :message_id
      t.integer :recruitment_id
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
    
    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :recruitment_id
    add_index :notifications, :message_id
    
  end
end
