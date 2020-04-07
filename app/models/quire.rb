class Quire < ApplicationRecord
  belongs_to :manuscript
  has_many :leaves, dependent: :destroy

  attr_accessor :leaf_count
  attr_accessor :xml_id

  # what about when quires are auto generated in manuscripts?
  after_save :create_leaves
  after_save :assign_leaf_positions
  after_save :xml_id

  validates_presence_of :leaf_count

  def create_leaves
    if leaf_count.present?
      (1..leaf_count.to_i).each do
        leaves.create
      end
    end
  end

  def assign_leaf_positions
    leaves.each_with_index do |leaf, index|
      leaf.position = index + 1
      leaf.opposite = leaves.size - index
    end
  end

  def xml_id
    "#{self.class.name.underscore}-#{id}"
  end
end
