require 'test_helper'

class MainsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get mains_top_url
    assert_response :success
  end

end
