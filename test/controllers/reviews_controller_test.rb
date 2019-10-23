require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    log_in_as(@user)
    @review = reviews(:one)
  end

  test "should create review" do
    assert_difference('Review.count') do
      post reviews_url, params: { review: { content: @review.content, rating: @review.rating, resume_id: @review.resume_id, user_id: @review.user_id } }
    end

    assert_redirected_to @review.resume
  end

  test "should update review" do
    patch review_url(@review), params: { review: { content: @review.content, rating: @review.rating, resume_id: @review.resume_id, user_id: @review.user_id } }
    assert_redirected_to @review.resume
  end

  test "should destroy review" do
    assert_difference('Review.count', -1) do
      delete review_url(@review)
    end

    assert_redirected_to @review.resume
  end
end
