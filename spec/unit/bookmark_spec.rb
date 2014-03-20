require 'test_helper'

describe "Bookmark" do
  let(:bookmark) { Pocketmarker::Bookmark.new("A webpage", "http://awebpage.com") }
  
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
    expect(bookmark.tags).to eq("one, two, three, four")
  end
end
