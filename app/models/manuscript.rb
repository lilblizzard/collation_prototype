class Manuscript < ApplicationRecord
  belongs_to :account, optional: true
end
