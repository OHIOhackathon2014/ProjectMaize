require 'test_helper'

class GraphControllerTest < ActionController::TestCase
  test "should get owner_compare" do
    get :owner_compare
    assert_response :success
  end

end
