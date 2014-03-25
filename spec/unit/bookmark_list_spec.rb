require 'test_helper'

describe "Pocketmarker::BookmarkList" do

  describe "importing bookmarks from a file" do
    context "when the file is a valid bookmark file" do
      it "adds bookmarks from a Firefox bookmark export" do
        bookmark_file = File.read("spec/support/firefox_bookmarks_12.html")
        bookmark_list = Pocketmarker::BookmarkList.create_from_file(bookmark_file)

        expect(bookmark_list.bookmarks.length).to eq(12)
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

      it "tags each bookmark based on the folders it is contained in" do
        bookmark_file = File.read("spec/support/opera_bookmarks_5.html")
        bookmark_list = Pocketmarker::BookmarkList.create_from_file(bookmark_file)

        expect(bookmark_list.bookmarks.first.tags.include?("Opera")).to eq(true)
        expect(bookmark_list.bookmarks.last.tags.include?("Travel")).to eq(true)
      end

      it "tags each bookmark with multiple tags if it's in a nested folder" do
        bookmark_file = File.read("spec/support/firefox_bookmarks_12.html")
        bookmark_list = Pocketmarker::BookmarkList.create_from_file(bookmark_file)

        expect(bookmark_list.bookmarks.last.tags.include?("news")).to eq(true)
      end
    end

    context "when a BookmarkList is a valid bookmark file but contains no bookmarks" do
      it "is empty" do
        bookmark_file = File.read("spec/support/empty_bookmarks.html")
        bookmark_list = Pocketmarker::BookmarkList.create_from_file(bookmark_file)

        expect(bookmark_list.empty?).to eq(true)
      end
    end

    context "when a BookmarkList is created from a file that is not a valid bookmark file" do
      it "is returns empty" do
        bookmark_file = File.read("spec/support/invalid_bookmark_file.html")
        bookmark_list = Pocketmarker::BookmarkList.create_from_file(bookmark_file)

        expect(bookmark_list.empty?).to eq(true)
      end
    end
  end

  describe "adding bookmarks" do
    let(:empty_bookmark_list) { Pocketmarker::BookmarkList.new }

    it "can add a single bookmark" do
      empty_bookmark_list.add(Pocketmarker::Bookmark.new("A single bookmark", "http://singlebookmark.com", []))
      expect(empty_bookmark_list.size).to eq(1)
    end

    it "can add an array of bookmarks" do
      bookmarks = []
      4.times {|n| bookmarks << Pocketmarker::Bookmark.new("Bookmark #{n}", "http://bookmark#{n}.com", []) }
      empty_bookmark_list.add(bookmarks)
      expect(empty_bookmark_list.size).to eq(4)
    end
  end

  describe "accessing a BookmarkList" do
    let(:bookmark_list) { Pocketmarker::BookmarkList.create_from_file(File.read("spec/support/chrome_bookmarks_2.html")) }

    it "can return a list of Bookmark objects" do
      expect(bookmark_list.bookmarks.class).to eq(Array)
    end

    it "knows when it is empty" do
      empty_bookmark_list = Pocketmarker::BookmarkList.new
      expect(empty_bookmark_list.empty?).to eq(true)
    end
  end
end
