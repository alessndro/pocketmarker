module Pocketmarker
  class Bookmark
    attr_reader :title, :url, :tags

    def initialize(title, url,tags)
      @title = title
      @url = url
      @tags = tags.is_a?(Array) ? tags : [] << tags
    end

    # Add one or more tags to this bookmark
    def add_tags(*tags)
      @tags += tags
    end

    def to_s
      "Name: #{@title}\nURL: #{@url}\nTags: #{@tags.join(", ")}"
    end

    def print_tags
      @tags.join(",")
    end

    def has_tags?
      @tags.empty? ? false : true
    end
  end
end
