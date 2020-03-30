class Quire < ApplicationRecord
  belongs_to :manuscript
  has_many :leaves, dependent: :destroy

  attr_accessor :leaf_count

  # what about when quires are auto generated in manuscripts?
  after_save :create_leaves
  after_save :assign_leaf_positions

  validates_presence_of :leaf_count

  def create_leaves
    if leaf_count.present?
      (0..leaf_count.to_i).each do |leaf|
        leaves.create
      end
    end
  end

  def assign_leaf_positions
    leaves.each_with_index do |leaf, index|
      leaf.position = index + 1
      leaf.opposite = leaves.size - index
      binding.pry
    end
  end
end
