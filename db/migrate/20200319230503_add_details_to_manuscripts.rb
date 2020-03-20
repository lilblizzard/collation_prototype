class AddDetailsToManuscripts < ActiveRecord::Migration[6.0]
  def change
    add_column :manuscripts, :name, :string
    add_column :manuscripts, :date, :integer
  end
end
