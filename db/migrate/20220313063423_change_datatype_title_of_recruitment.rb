class ChangeDatatypeTitleOfRecruitment < ActiveRecord::Migration[6.1]
  def change
    change_column :recruitments, :title, :string
  end
end
