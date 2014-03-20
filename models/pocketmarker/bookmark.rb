module Pocketmarker
  class Bookmark
    attr_reader :title, :url

    def initialize(title, url)
      @title = title
      @url = url
      @tags = []
    end

    # Add one or more tags to this bookmark
    def add_tags(*tags)
      @tags += tags
    end

    def tags
      @tags.join(", ")
    end
  end
end