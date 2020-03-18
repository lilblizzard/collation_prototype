class CreateQuires < ActiveRecord::Migration[6.0]
  def change
    create_table :quires do |t|
      t.references :manuscript, null: false, foreign_key: true
      t.integer :leaf_count

      t.timestamps
    end
  end
end
