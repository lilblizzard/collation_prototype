class Manuscript < ApplicationRecord
  belongs_to :account
  has_many :quires, dependent: :destroy

  # attr_accessor allows us access to this
  # parameter (coming from the form), in our model
  attr_accessor :quire_count

  after_save :create_quires

  validates_presence_of :name, :shelfmark

  def create_quires
    if quire_count.present?
      quire_count.to_i.times do
        quires.create!
      end
    end
  end
end
