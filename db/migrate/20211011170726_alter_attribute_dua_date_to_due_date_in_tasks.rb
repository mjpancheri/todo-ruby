class AlterAttributeDuaDateToDueDateInTasks < ActiveRecord::Migration[6.1]
  def change
    rename_column :tasks, :dua_date, :due_date
  end
end
