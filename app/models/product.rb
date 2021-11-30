class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true, allow_blank: false
  validates :url, uniqueness: true, presence: true, allow_blank: false
  validates :url, format: URI::DEFAULT_PARSER.make_regexp(%w[https http])
end
