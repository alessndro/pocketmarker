require 'test_helper'

describe "Pocketmarker::Bookmark" do
  let(:bookmark) { Pocketmarker::Bookmark.new("A webpage", "http://awebpage.com", %w{tag_one tag_two}) }

  it "has a valid constructor" do
    expect(bookmark.class).to equal(Pocketmarker::Bookmark)
  end

  it "has a title" do
    expect(bookmark.title).to eq("A webpage")
  end

  it "has a URL" do
    expect(bookmark.url).to eq("http://awebpage.com")
  end

  it "can have a list of tags" do
    bookmark.add_tags(["one", "two", "three", "four"])
    expect(bookmark.print_tags).to eq("tag_one,tag_two,one,two,three,four")
  end
end
