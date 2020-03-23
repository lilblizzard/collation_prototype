class Manuscript < ApplicationRecord
  belongs_to :account
  has_many :quires, dependent: :destroy

  attr_accessor :quire_count

  after_save :create_quires

  validates_presence_of :name, :shelfmark

  def create_quires
    if quire_count.present?
      quire_count.to_i.times do
        quires.create
      end
    end
      # self.quire_count = nil
  end

end
