class RemoveQuireCountFromManuscripts < ActiveRecord::Migration[6.0]
  def change

    remove_column :manuscripts, :quire_count, :integer
  end
end
