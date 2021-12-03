require 'open-uri'
require 'nokogiri'

def scraper(category)
  html_file = URI.open("https://www.producthunt.com/search?q=#{category}").read
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search(".styles_item__2kQQ5").each do |product|
    name = product.search(".styles_content__3rHRc a").children.first.text
    link = product.search(".styles_content__3rHRc a").attribute('href').value
    product_page = URI.open("https://www.producthunt.com#{link}").read
    product_doc = Nokogiri::HTML(product_page)
    path = product_doc.search(".styles_headerInfo__3h0jF h1 a").attribute('href').value
    begin
      product_site = URI.open("https://www.producthunt.com#{path}")
      product_html = Nokogiri::HTML(product_site)
    rescue RuntimeError => e
      if />.*[?]/.match(e.message)
        url = />.*[?]/.match(e.message).to_s.chars[2...-1].join
      else
        url = />.*/.match(e.message).to_s.chars[2..].join
      end
    end
    url = "https://www.producthunt.com#{path}" if url.nil?
    Product.new(name: name, url: url)
  end
end
