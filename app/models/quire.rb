class Quire < ApplicationRecord
  belongs_to :manuscript
  has_many :leaves, dependent: :destroy

  attr_accessor :leaf_count
  attr_accessor :xml_id

  # what about when quires are auto generated in manuscripts?
  after_save :create_leaves
  after_save :xml_id

  validates_presence_of :leaf_count

  acts_as_list scope: :manuscript

  def create_leaves
    if leaf_count.present?
      (1..leaf_count.to_i).each do
        leaves.create
      end
    end
  end

  def xml_id
    "quire-#{id}"
  end

  def units
    units = []
    leaf_queue = leaves.map &:itself
    while leaf_queue.count > 0
      leaf = leaf_queue.shift
      opposite = leaf_queue.pop
      if opposite.nil?
        units << [leaf]
      else
        units << [leaf, opposite]
      end
    end
    units
  end

  def set_conjoins(units)
    units.each do |unit|
      if unit[1].nil?
        unit[0].conjoin = nil
      else
        unit[0].conjoin = unit[1]
        unit[1].conjoin = unit[0]
      end
    end
  end
end
