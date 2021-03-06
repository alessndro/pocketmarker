require 'test_helper'

describe "Uploading bookmarks", :type => :feature do

  context "when the user is not logged in via Pocket" do
    it "should redirect the user to the homepage and notify them" do
      visit '/upload_bookmarks'
      #expect(page).to have_content("You need to log in Via Pocket to access this section")
    end
  end

  context "when the user has successfully logged in via Pocket" do
    before do
      visit '/'
      click_link("Log in via Pocket")
    end

    describe "the upload form" do
      it "is displayed on the page" do
        expect(page).to have_css("form.upload-form")
      end

      it "allows files to be uploaded" do
        expect(page).to have_css("input[type=file]")
      end

      it "accepts html files" do
        expect(page).to have_css("input[accept='.html']")
      end
    end

    context "when the bookmarks file is valid" do
      before do
        visit '/'
        click_link("Log in via Pocket")
        attach_file("bookmark_file", "spec/support/chrome_bookmarks_2.html")
        click_button("Upload Bookmarks")
      end

      describe "uploading a bookmark file"  do
        it "displays the titles of bookmarks that were in the uploaded file" do
          expect(page).to have_field("[bookmark-0][title]", with: "News")
          expect(page).to have_field("[bookmark-0][url]", with: "http://news.com")
        end

        it "displays the URL of bookmarks that were in the uploaded file" do
          expect(page).to have_field("[bookmark-1][title]", with: "ESPN: The Worldwide Leader In Sports")
          expect(page).to have_field("[bookmark-1][url]", with: "http://espn.go.com/")
        end

        it "displays a checkbox for each bookmark in the uploaded file" do
          expect(page).to have_checked_field("[bookmark-0][add]")
          expect(page).to have_checked_field("[bookmark-1][add]")
        end

        it "displays any tags derived form the folder the bookmark was in" do
          expect(page).to have_field("[bookmark-1][tags]", with: "Bookmarks Bar")
        end
      end
    end

    context "when the bookmark file is invalid" do
      describe "uploading a file with no bookmarks" do
        it "should notify the user that the file was invalid" do
          visit '/'
          click_link("Log in via Pocket")
          attach_file("bookmark_file", "spec/support/empty_bookmarks.html")
          click_button("Upload Bookmarks")
          expect(page).to have_content("The file was either corrupted or did not contain any bookmarks")
        end
      end
    end
  end
end
