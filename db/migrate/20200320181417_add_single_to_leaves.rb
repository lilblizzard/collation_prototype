class AddSingleToLeaves < ActiveRecord::Migration[6.0]
  def change
    add_column :leaves, :single, :boolean
  end
end
