class Leaf < ApplicationRecord
  belongs_to :quire
  acts_as_list scope: :quire
end
