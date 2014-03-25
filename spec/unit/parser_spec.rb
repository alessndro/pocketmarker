require 'test_helper'

describe "Pocketmarker::Parser" do

  it "has a valid constructor" do
    parser = Pocketmarker::Parser.new(File.read("spec/support/firefox_bookmarks_12.html"))
    expect(parser.class).to equal(Pocketmarker::Parser)
  end

  context "when the bookmarks file contains nested bookmarks" do
    let(:parser) { Pocketmarker::Parser.new(File.read("spec/support/firefox_bookmarks_12.html")) }

    it "parses bookmarks with nested folders" do
      bookmark_strings = []
      parser.parse do |bookmark_name, bookmark_url, bookmark_tags|
        bookmark_strings << "#{bookmark_name}, #{bookmark_url}, #{bookmark_tags}"
      end

      expect(bookmark_strings.last).to eq("MoneySavingExpert.com Forums, http://forums.moneysavingexpert.com/, news")
    end
  end

  context "when the bookmarks file is empty" do
    let(:parser) { Pocketmarker::Parser.new(File.read("spec/support/empty_bookmarks.html")) }

    it "parses no bookmarks" do
      bookmark_strings = []
      parser.parse do |bookmark_name, bookmark_url, bookmark_tags|
        bookmark_strings << "#{bookmark_name}, #{bookmark_url}, #{bookmark_tags}"
      end

      expect(bookmark_strings.empty?).to eq(true)
    end
  end

  context "when the bookmarks file is not valid" do
    let(:parser) { Pocketmarker::Parser.new(File.read("spec/support/invalid_bookmark_file.html")) }

    it "parses no bookmarks" do
      bookmark_strings = []
      parser.parse do |bookmark_name, bookmark_url, bookmark_tags|
        bookmark_strings << "#{bookmark_name}, #{bookmark_url}, #{bookmark_tags}"
      end

      expect(bookmark_strings.empty?).to eq(true)
    end
  end
end
