class Quire < ApplicationRecord
  belongs_to :manuscript
  has_many :leaves, dependent: :destroy
  accepts_nested_attributes_for :leaves, allow_destroy: true

  attr_accessor :leaf_count
  attr_accessor :xml_id

  #validate :even_bifolia

  # what about when quires are auto generated in manuscripts?
  after_save :create_leaves
  after_save :xml_id

  #validates_presence_of :leaf_count

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
    units_hash = {}
    units.each do |unit|
      units_hash[unit[0]] = unit[1]
      units_hash[unit[1]] = unit[0] if unit[1]
    end
    units_hash
  end

  def even_bifolia
    conjoins = leaves.reject { |leaf| leaf.single? }.size
    if conjoins.odd?
      errors.add(:base, "The number of non-single leaves cannot be odd; found: #{conjoins}")
    end
  end
end
