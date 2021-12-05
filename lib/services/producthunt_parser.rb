class ProducthuntParser
  class << self
    def parse_product_page(product_doc)
      bio = parse_bio(product_doc)
      info = parse_info(product_doc)
      {
        bio: bio,
        info: info
      }
    end

    private
      def parse_bio(product_doc)
        bio_paragraphs = product_doc.search("[class*=styles_headerPostTagline]")
        raise "expected one bio line" unless bio_paragraphs.count == 1
        bio_paragraphs.first.text
      end

      def parse_info(product_doc)
        info_sections = product_doc.search("[class*=styles_description__]")
        raise "expected zero or one section, found #{info_sections.count}" if info_sections.count > 1
        info_sections.first&.text
      end
  end
end
