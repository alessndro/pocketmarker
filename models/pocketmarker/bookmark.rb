module Pocketmarker
  class Bookmark
    attr_reader :title, :url

    def initialize(title, url)
      @title = title
      @url = url
    end
  end
end