require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)  # fixturesでカテゴリデータを使用
  end

  test "should get index" do
    get categories_path
    assert_response :success
    assert_select "title", "Home | Todo App"
  end

  test "should get new" do
    get new_category_path
    assert_response :success
    assert_select "title", "Make | Todo App"
  end

  test "should get show" do
    get category_path(@category)
    assert_response :success
    assert_select "title", "Show | Todo App"
  end
end
