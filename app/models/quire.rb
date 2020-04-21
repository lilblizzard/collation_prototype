# frozen_string_literal: true

class Quire < ApplicationRecord
  belongs_to :manuscript
  has_many :leaves, dependent: :destroy
  accepts_nested_attributes_for :leaves, allow_destroy: true

  attr_accessor :leaf_count
  attr_accessor :xml_id

  validate :even_bifolia

  # what about when quires are auto generated in manuscripts?
  after_save :create_leaves
  after_save :xml_id

  # validates_presence_of :leaf_count

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
    # when we encounter a single, shift it off, put in
    # new array
    conjoined_leaf_queue = conjoined_leaves.map &:itself
    while conjoined_leaf_queue.count > 0
      leaf = conjoined_leaf_queue.shift
      opposite = conjoined_leaf_queue.pop
      units << if opposite.nil?
                 [leaf]
               else
                 [leaf, opposite]
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
    conjoins = leaves.reject(&:single?).size
    if conjoins.odd?
      errors.add(:base, "The number of non-single leaves cannot be odd; found: #{conjoins}")
    end
  end

  def conjoined_leaves
    leaves.reject(&:single?)
  end

  def singles
    leaves.select(&:single?)
  end
end
