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
            units_hash = quire.units
            xml.quire('xml:id': quire.xml_id, position: "#{quire.position}")
          end
        }
        xml.leaves {
          quires.each do |quire|
            units_hash = quire.units
            quire.leaves.each_with_index do |leaf, index|
              xml.leaf('xml:id': leaf.xml_id) {
                xml.folio_number('certainty': 1, 'val': index + 1)
                xml.mode('certainty': 1, 'val': leaf.mode)
                xml.q('target': "##{leaf.quire.xml_id}", 'position': leaf.position) {
                  if units_hash[leaf]
                    xml.conjoin('certainty': 1, 'target': "##{units_hash[leaf].xml_id}")
                  end
                }
              }
            end
          end
        }
      }
    end.to_xml
  end
end
