class Manuscript < ApplicationRecord
  belongs_to :account
  has_many :quires, dependent: :destroy
  has_many :leaves, through: :quires

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
            xml.quire('xml:id': quire.xml_id, position: "#{quire.position}")
          end
        }
        xml.leaves {
          leaves.each_with_index do |leaf, index|
            xml.leaf(target: "##{leaf.quire.xml_id}", folio_number: "#{index + 1}", position: "#{leaf.position}")
          end
        }
      }
    end.to_xml
  end
end
