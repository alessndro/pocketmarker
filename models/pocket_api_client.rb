require 'typhoeus'
require 'json'

class PocketAPIClient

  API_BASE_ENDPOINT = "https://getpocket.com/v3/"

  def initialize(consumer_key, access_token)
    @consumer_key = consumer_key
    @access_token = access_token
  end

  # Calls the Modify endpoint of the Pocket API.
  # We use this rather than the Add endpoint since it allows batch adding
  # of items
  def add_items(bookmarks)
    request = Typhoeus::Request.new(API_BASE_ENDPOINT + 'send', 
                                    method: :post,
                                    body: modify_request_body(bookmarks),
                                    headers: { "Content-Type"=> "application/json; charset=UTF-8", 
                                               "X-Accept"=> "application/json" }
                                    )
    response = request.run
    return response.success?
  end

  private

  # Forms the body of a Modify API request.
  # Return JSON
  def modify_request_body(bookmarks)
    request_body = { consumer_key: @consumer_key, 
                    access_token: @access_token }

    bookmark_json_array = []

    bookmarks.each do |bookmark|
      bookmark_json_array << { "action" => "add",
                               "title" => bookmark.title,
                               "url" => bookmark.url
                              }
    end

    request_body[:actions] = bookmark_json_array
    
    return request_body.to_json
  end
end