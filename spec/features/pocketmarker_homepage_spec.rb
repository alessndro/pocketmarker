require 'test_helper'

describe "Pocketmarker homepage", :type => :feature do

  it "has a title" do
    visit '/'
    expect(page).to have_content "Upload bookmarks and add them to your Pocket queue

"
  end

  it "has a link to log in via Pocket" do
    visit '/'
    expect(page).to have_content "Log in via Pocket"
  end
end
