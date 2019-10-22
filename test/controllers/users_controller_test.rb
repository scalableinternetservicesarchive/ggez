require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    log_in_as(@user)
  end

  test "should not get index" do
    assert_raise do
      get users_url
    end
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    @user.resumes.each(&:destroy)
    @user.destroy
    assert_difference('User.count') do
      post users_url, params: { user: { industry: @user.industry, password: 'secret', password_confirmation: 'secret', username: @user.username } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should require login to update user" do
    patch user_url(@user), params: { user: { industry: @user.industry, password: 'secret', password_confirmation: 'secret', username: @user.username } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to root_url
  end
end
