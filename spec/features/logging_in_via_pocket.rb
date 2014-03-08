require 'test_helper'

describe "Logging in via Pocket", :type => :feature do
  describe "when the user has not authenticated the app" do
    it "has a title" do
      visit '/'
      click_link "Log in via Pocket"
      expect(page).to have_content "fff"
    end
  end
end
