class RenameMessagesColumnToMessages < ActiveRecord::Migration[6.1]
  def change
    rename_column :messages, :messages, :message
  end
end
