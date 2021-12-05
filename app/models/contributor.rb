class Contributor < ApplicationRecord
  belongs_to :list
  belongs_to :user

  accepts_nested_attributes_for :user
  acts_as_voter

  enum role: [:editor, :owner]
end
