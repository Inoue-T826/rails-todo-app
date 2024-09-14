require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Home | Todo App"
  end

  test "should get make" do
    get make_path
    assert_response :success
    assert_select "title", "Make | Todo App"
  end
end
