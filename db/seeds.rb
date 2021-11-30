# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
categories = [
  "accounting",
  "graphics",
  "marketing",
  "legal",
  "project management",
  "sales",
  "CRM"
]
categories.each do |category|
  tag = ActsAsTaggableOn::Tag.find_by(name: category)
  ActsAsTaggableOn::Tag.create!(name: category) if tag.nil?
end
