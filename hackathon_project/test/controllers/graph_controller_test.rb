require 'test_helper'

class GraphControllerTest < ActionController::TestCase
  test "should get compare" do
    get :compare
    assert_response :success
  end

end
