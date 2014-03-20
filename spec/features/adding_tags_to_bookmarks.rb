require 'test_helper'

describe "adding tags to a bookmark" do
  before do
    visit '/'
    click_link("Log in via Pocket")
    attach_file("bookmark_file", "spec/support/chrome_bookmarks_2.html")
    click_button("Upload Bookmarks")
  end

  it "adds tags to selected bookmarks" do
  end
end