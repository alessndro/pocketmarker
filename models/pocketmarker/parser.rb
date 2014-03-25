require 'nokogiri'

module Pocketmarker
  class Parser
    def initialize(file)
      # Use nonet config for untrusted documents, which prevents network connections
      @document = Nokogiri::HTML::Document.parse(file) { |config| config.nonet }
    end

    # Parses the current document, executing the given block for each bookmark found
    def parse(&block)
      traverse(@document, [], &block)
    end

    private

    def traverse(root, folders, &block)

      root.xpath("./*").each do |child|
        if child.name.downcase == "dl"
          traverse(child, folders, &block)
        elsif child.name.downcase == "a"
          # Only use the last folder since folders may be nested and we only
          # want the parent folder, not the grandparent etc
          yield(child.text, child.attributes["href"].value, folders.last)
        elsif child.name.downcase == "h3"
          folders << child.text
        else
          if child.children.any?
            traverse(child, folders, &block)
          end
        end
      end
    end
  end
end
