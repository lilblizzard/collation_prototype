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
end
