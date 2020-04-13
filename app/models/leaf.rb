class Leaf < ApplicationRecord
  belongs_to :quire
  acts_as_list scope: :quire

  MODES = %w( original added replaced missing )

  def xml_id
    "#{self.quire.id}-#{id}"
  end
end
