class Contributor < ApplicationRecord
  belongs_to :list
  belongs_to :user

  enum role: [:user, :owner]
end
