require 'test_helper'

describe "PocketApiClient" do
  let(:bookmark_list) { Pocketmarker::BookmarkList.create_from_file(File.read("spec/support/chrome_bookmarks_2.html")) }

  it "is instantiated using a consumer key and an access token" do
    client = PocketAPIClient.new("consumerkey", "accesstoken")
    expect(client.class).to eq(PocketAPIClient)
  end

  it "can use the API to add items to a Pocket account" do
    # Stub the eventual API call
    #stub_request(:post, "https://getpocket.com/v3/send").to_return(:status => 200, :body => "", :headers => {})
    
    client = PocketAPIClient.new("1","2")
    expect(client.add_items(bookmark_list.bookmarks)).to be_true
  end
end