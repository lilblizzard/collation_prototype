class Leaf < ApplicationRecord
  belongs_to :quire
  acts_as_list scope: :quire

  attr_accessor :conjoin

  MODES = %w( Original Added Replaced Missing )

  def xml_id
    "leaf-#{id}"
  end
end
