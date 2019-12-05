class ReviewsController < ApplicationController
  before_action :set_review, only: %i[update destroy]
  before_action :check_user, only: %i[update destroy]

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user["id"]
    if @review.save
      @review.resume.user.update(points: @review.resume.user.points - 1)
      User.update(current_user["id"], points: current_user["points"] + 1)
      redirect_to @review.resume, notice: 'Review was successfully created.'
    else
      redirect_to @review.resume, notice: 'Review was not successfully created.'
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    if @review.update(review_params)
      redirect_to @review.resume, notice: 'Review was successfully updated.'
    else
      redirect_to @review.resume, notice: 'Review was not successfully updated.'
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    redirect_to @review.resume, notice: 'Review was successfully deleted.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  def check_user
    return if logged_in? && @review.user_id == current_user["id"]

    redirect_to root_path
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def review_params
    params.require(:review).permit(:rating, :content, :resume_id)
  end
end
