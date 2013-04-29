require 'test_helper'

class ChiliPublisherControllerTest < ActionController::TestCase
  setup do
    
  end

  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get editor" do
    get :editor
    assert_response :success
  end

end
