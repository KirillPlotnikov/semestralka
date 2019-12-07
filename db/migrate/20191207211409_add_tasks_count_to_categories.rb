class AddTasksCountToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :tasks_count, :integer, default: 0, null: false
  end
end
