require "test_helper"

class RecruitmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get recruitments_new_url
    assert_response :success
  end

  test "should get index" do
    get recruitments_index_url
    assert_response :success
  end

  test "should get show" do
    get recruitments_show_url
    assert_response :success
  end

  test "should get edit" do
    get recruitments_edit_url
    assert_response :success
  end
end
