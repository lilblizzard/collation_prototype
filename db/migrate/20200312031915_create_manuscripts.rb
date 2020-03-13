class CreateManuscripts < ActiveRecord::Migration[6.0]
  def change
    create_table :manuscripts do |t|
      t.references :account
      t.string :shelfmark
      t.integer :quire_count

      t.timestamps
    end
  end
end
