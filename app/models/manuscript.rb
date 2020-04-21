# frozen_string_literal: true

class Manuscript < ApplicationRecord
  belongs_to :account
  has_many :quires, dependent: :destroy
  has_many :leaves, through: :quires

  # attr_accessor allows us access to this
  # parameter (coming from the form), in our model
  attr_accessor :quire_count
  validates_presence_of :name, :shelfmark

  def create_xml(_name, _shelfmark, _date)
    Nokogiri::XML::Builder.new do |xml|
      xml.viscoll('xmlns:tei': 'http://www.tei-c.org/ns/1.0', 'xmlns': 'http://schoenberginstitute.org/schema/collation') do
        xml.textblock do
          build_manuscript_xml(xml)
          build_quires_xml(xml)
          build_leaves_xml(xml)
        end # xml.textblock
      end # xml.viscoll
    end.to_xml # Nokogiri::XML::Builder.new
  end # def create_xml

  def build_manuscript_xml(xml)
    xml.title name
    xml.shelfmark shelfmark
    xml.date date
    xml.direction('val': 'l-r')
  end

  def build_quires_xml(xml)
    xml.quires do
      quires.each do |quire|
        units_hash = quire.units
        xml.quire('xml:id': quire.xml_id, n: quire.position.to_s) do
          xml.text(quire.position.to_s)
        end
      end # quires.each
    end # xml.quires
  end

  def build_leaves_xml(xml)
    xml.leaves do
      quires.each do |quire|
        units_hash = quire.units
        quire.leaves.each_with_index do |leaf, index|
          xml.leaf('xml:id': leaf.xml_id) do
            xml.folio_number('certainty': 1, 'val': index + 1)
            xml.mode('certainty': 1, 'val': leaf.mode)
            xml.q('target': "##{leaf.quire.xml_id}", 'position': leaf.position) do
              if leaf.single?
                xml.single('val': 'yes')
              elsif units_hash[leaf]
                xml.conjoin('certainty': 1, 'target': "##{units_hash[leaf].xml_id}")
              end
            end
          end # if leaf.single?
        end #
      end #
    end # xml.leaves
  end
end
