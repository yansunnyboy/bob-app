class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true, allow_blank: false
  validates :url, uniqueness: true, presence: true, allow_blank: false
  validates :url, format: URI::DEFAULT_PARSER.make_regexp(%w[https http])

  acts_as_taggable_on :categories, :businesses, :costs

  BUSINESS_SIZES = [
    "small",
    "medium",
    "large"
  ]

  COST_CATEGORIES = [
    "free",
    "trial-available",
    "up-front",
    "subscription"
  ]
end
