class CreateLeaves < ActiveRecord::Migration[6.0]
  def change
    create_table :leaves do |t|
      t.references :quire, null: false, foreign_key: true

      t.timestamps
    end
  end
end
