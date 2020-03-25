class Quire < ApplicationRecord
  belongs_to :manuscript
  has_many :leaves, dependent: :destroy

  attr_accessor :leaf_count

  # what about when quires are auto generated in manuscripts?
  after_save :create_leaves

  validates_presence_of :leaf_count

  def create_leaves
    if leaf_count.present?
      leaf_count.to_i.times do
        leaves.create
      end
    end
  end
end
