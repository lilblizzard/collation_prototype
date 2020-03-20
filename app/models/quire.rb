class Quire < ApplicationRecord
  belongs_to :manuscript
  has_many :leaves
end
