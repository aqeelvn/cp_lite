class MakeUserActivitiesUseSti < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_activities, :action, :type
    update <<-SQL
      UPDATE user_activities SET type = 'BookmarkActivity'
    SQL
  end
end
