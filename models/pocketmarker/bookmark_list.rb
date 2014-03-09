require 'nokogiri'
require_relative './bookmark.rb'

module Pocketmarker
  class BookmarkList
    attr_reader :bookmarks

    def initialize
      @bookmarks = []
    end

    # Add an array of Bookmarks, or a single Bookmark
    def add(bookmarks)
      if bookmarks.is_a?(Array)
        @bookmarks += bookmarks
      else
        @bookmarks << bookmarks
      end
    end

    def size
      @bookmarks.length
    end

    # Parses a Netscape bookmark file and creates new Bookmarks
    # Extraction of bookmarks from the file is slightly crude since it differentiates
    # actual bookmark links in the file using the existence of the ADD_DATE attribute.
    # Unfortunately the Netscape bookmark format isn't particularly strict and each browser
    # uses a slightly modified version of it
    def self.create_from_file(file)
      bookmark_doc = Nokogiri::XML::Document.parse(file)

      bookmarks = []

      bookmark_doc.xpath("//A").each do |link_node|
        # If the anchor doesn't have the ADD_DATE attribute, it isn't an
        # actual bookmark, so skip it
        next if !link_node.attributes.has_key?("ADD_DATE")
        
        bookmark_title = link_node.children.text || "No Name"
        bookmark_url = link_node.attributes["HREF"].value

        bookmarks << Pocketmarker::Bookmark.new(bookmark_title, bookmark_url)
      end
      
      bookmark_list = self.new
      bookmark_list.add(bookmarks)
      return bookmark_list
    end

    def to_s
      bookmark_string = ""
      bookmark_string << "Total Bookmarks: #{@bookmarks.length}"
      @bookmarks.each do |bookmark|
        bookmark_string << "\n\nName: #{bookmark.title}\nURL: #{bookmark.url}"
      end

      return bookmark_string
    end
  end
end