require 'test_helper'

describe "Logging in via Pocket", :type => :feature do
    it "allows the user to log in via Pocket" do
      visit '/'
      click_link "Log in via Pocket"
      expect(page).to have_content("You have successfully logged in")
    end

    context "after successfully logging in" do
      it "redirects the user to the Upload Bookmarks page" do
        visit '/'
        click_link "Log in via Pocket"
        expect(page).to have_content("Upload Your Bookmarks")
      end
    end
end
