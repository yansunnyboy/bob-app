class Contributor < ApplicationRecord
  belongs_to :list
  belongs_to :user

  # delegate :email, to: :user
  accepts_nested_attributes_for :user
  
  enum role: [:editor, :owner]
end
