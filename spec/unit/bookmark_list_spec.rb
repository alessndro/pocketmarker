require 'test_helper'

describe "BookmarkList" do

  describe "importing bookmarks from a file" do
    it "adds bookmarks from a Firefox bookmark export" do
      bookmark_file = File.read("spec/support/firefox_bookmarks_7.html")
      bookmark_list = Pocketmarker::BookmarkList.create_from_file(bookmark_file)

      expect(bookmark_list.bookmarks.length).to eq(7)
    end

    it "adds bookmarks from an Opera bookmark export" do
      bookmark_file = File.read("spec/support/opera_bookmarks_5.html")
      bookmark_list = Pocketmarker::BookmarkList.create_from_file(bookmark_file)

      expect(bookmark_list.bookmarks.length).to eq(5)
    end

    it "adds bookmarks from a Chrome bookmark export" do
      bookmark_file = File.read("spec/support/chrome_bookmarks_2.html")
      bookmark_list = Pocketmarker::BookmarkList.create_from_file(bookmark_file)
      
      expect(bookmark_list.bookmarks.length).to eq(2)
    end
  end

  describe "adding bookmarks" do
    let(:empty_bookmark_list) { Pocketmarker::BookmarkList.new }

    it "can add a single bookmark" do
      empty_bookmark_list.add(Pocketmarker::Bookmark.new("A single bookmark", "http://singlebookmark.com"))
      expect(empty_bookmark_list.size).to eq(1)
    end

    it "can add an array of bookmarks" do
      bookmarks = []
      4.times {|n| bookmarks << Pocketmarker::Bookmark.new("Bookmark #{n}", "http://bookmark#{n}.com") }
      empty_bookmark_list.add(bookmarks)
      expect(empty_bookmark_list.size).to eq(4)
    end
  end

  describe "accessing a BookmarkList" do
    let(:bookmark_list) { Pocketmarker::BookmarkList.create_from_file(File.read("spec/support/chrome_bookmarks_2.html")) }

    it "can return a list of Bookmark objects" do
      expect(bookmark_list.bookmarks.class).to eq(Array)
    end


    it "pretty prints its contents" do
      expect(bookmark_list.to_s).to eq("Total Bookmarks: 2\n\nName: News\nURL: http://news.com\n\nName: ESPN: The Worldwide Leader In Sports\nURL: http://espn.go.com/")
    end
  end
end
