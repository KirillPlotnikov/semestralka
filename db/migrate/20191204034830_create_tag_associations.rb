class CreateTagAssociations < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_associations do |t|
      t.references :task, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
