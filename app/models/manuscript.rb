class Manuscript < ApplicationRecord
  belongs_to :account
  has_many :quires
end
