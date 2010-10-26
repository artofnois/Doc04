require 'test_helper'

class PruControllerTest < ActionController::TestCase
  test "should get pru" do
    get :pru
    assert_response :success
  end

end
