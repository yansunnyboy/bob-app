class Solution < ApplicationRecord
  belongs_to :list
  belongs_to :product

  acts_as_votable
end
