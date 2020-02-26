require 'test_helper'

class QuoteControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get quote_show_url
    assert_response :success
  end

  test "should get create" do
    get quote_create_url
    assert_response :success
  end

  test "should get update" do
    get quote_update_url
    assert_response :success
  end

end
