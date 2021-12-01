# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'nokogiri'
require 'byebug'

users = [{ email: "qwerty@gmail.com", password: "qwerty" }, { email: "bob@gmail.com", password: "azerty" },
         { email: "yan@gmail.com", password: "qwerty" }]

users.each do |el|
  user = User.new(
      :email                 => el[:email],
      :password              => el[:password],
      :password_confirmation => el[:password]
    )
  user.save
end


categories = [
  "bookkeeping",
  "user experience",
  "developer tools",
  "marketing",
  "CRM",
  "design tools",
  "productivity",
  "analytics"
]

categories.each do |category|
  tag = ActsAsTaggableOn::Tag.find_by(name: category)
  ActsAsTaggableOn::Tag.create!(name: category) if tag.nil?
end

categories.each do |category|
  category.gsub!(/\s/, "%20") if /.+\s.+/.match(category)
  html_file = URI.open("https://www.producthunt.com/search?q=#{category}").read
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search(".styles_item__2kQQ5").each do |product|
    name = product.search(".styles_content__3rHRc a").children.first.text
    bio = product.search(".styles_grey__3J1TQ").children.first.text
    link = product.search(".styles_content__3rHRc a").attribute('href').value
    product_page = URI.open("https://www.producthunt.com#{link}").read
    product_doc = Nokogiri::HTML(product_page)
    info = product_doc.search(".styles_main__48OVQ p").children.text
    path = product_doc.search(".styles_headerInfo__3h0jF h1 a").attribute('href').value
    begin
      URI.open("https://www.producthunt.com#{path}")
    rescue OpenURI::HTTPError, Errno::EHOSTUNREACH, Net::OpenTimeout, Errno::ECONNREFUSED
      next
    rescue RuntimeError => e
      if />.*[?]/.match(e.message)
        url = />.*[?]/.match(e.message).to_s.chars[2...-1].join
      else
        url = />.*/.match(e.message).to_s.chars[2..].join
      end
    end
    url = "https://www.producthunt.com#{path}" if url.nil?
    Product.create(name: name, url: url, bio: bio, info: info)
  end
end
