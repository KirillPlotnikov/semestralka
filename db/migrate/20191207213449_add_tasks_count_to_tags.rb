class AddTasksCountToTags < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :tasks_count, :integer, default: 0, null: false
  end
end
