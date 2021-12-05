class List < ApplicationRecord
  has_many :contributors

  acts_as_votable
end
