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
end
