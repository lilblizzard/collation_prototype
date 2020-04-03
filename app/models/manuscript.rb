class Manuscript < ApplicationRecord
  belongs_to :account
  has_many :quires, dependent: :destroy

  # attr_accessor allows us access to this
  # parameter (coming from the form), in our model
  attr_accessor :quire_count
  validates_presence_of :name, :shelfmark

  def create_xml(name, shelfmark, date)
    Nokogiri::XML::Builder.new do |xml|
      xml.manuscript {
        xml.name name
        xml.shelfmark shelfmark
        xml.date date

        xml.quires {
          quires.each do |quire|
            xml.quire(id: quire.id)
          end
        }
      }
    end.to_xml
  end
end
