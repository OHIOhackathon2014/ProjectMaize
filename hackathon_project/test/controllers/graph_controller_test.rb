require 'test_helper'

class GraphControllerTest < ActionController::TestCase
  test "should get line_graph" do
    get :line_graph
    assert_response :success
  end

end
