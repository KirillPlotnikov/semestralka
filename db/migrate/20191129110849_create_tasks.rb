class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.datetime :deadline_at
      t.string :title
      t.text :note
      t.boolean :is_done
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
