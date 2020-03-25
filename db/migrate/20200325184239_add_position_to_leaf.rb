class AddPositionToLeaf < ActiveRecord::Migration[6.0]
  def change
    add_column :leaves, :position, :integer
  end
end
