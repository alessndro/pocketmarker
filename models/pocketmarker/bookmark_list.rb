require_relative './bookmark.rb'
require_relative './parser.rb'

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

    def empty?
      size == 0
    end

    # Creates a list of bookmarks from a bookmark file, passing the file to a Parser
    # to do most of the work
    def self.create_from_file(file)
      parser = Pocketmarker::Parser.new(file)

      bookmarks = []

      parser.parse do |bookmark_title, bookmark_url, bookmark_tags|
        bookmarks << Pocketmarker::Bookmark.new(bookmark_title, bookmark_url, bookmark_tags)
      end

      bookmark_list = self.new
      bookmark_list.add(bookmarks)

      bookmark_list
    end

    def to_s
      bookmark_string = ""
      bookmark_string << "Total Bookmarks: #{@bookmarks.length}"

      @bookmarks.each do |bookmark|
        bookmark_string << "\n\n#{bookmark}"
      end

      bookmark_string
    end
  end
end
