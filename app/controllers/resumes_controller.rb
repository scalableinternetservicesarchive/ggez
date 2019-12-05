class ResumesController < ApplicationController
  before_action :set_resume, only: %i[show destroy swap_public]
  before_action :check_user, only: %i[show destroy swap_public]
  # GET /resumes/1
  def show; end

  # GET /resumes/new
  def new
    @resume = Resume.new
  end

  # POST /resumes
  def create
    @resume = Resume.new(resume_params)
    @resume.user_id = current_user["id"]

    if @resume.save
      redirect_to root_path, notice: "The resume for user #{@resume.user_id} has been created."
    else
      render :new
    end

  end

  # DELETE /resumes/1
  def destroy
    @resume.destroy
    redirect_to resumes_url, notice: 'Resume was successfully deleted.'
  end

  def swap_public
    @resume.public = !@resume.public
    @resume.save
    redirect_to root_path
  end

  def random
    unless logged_in?
      redirect_to root_path
      return
    end

    # To keep load testing simple and consistent,
    # we won't worry about this condition:
    # Resume.joins(:user, :reviews)
    # .where.not(reviews: { user_id: current_user.id })
    resume = Resume.joins(:user)
                   .where(public: true)
                   .where.not(user_id: current_user["id"])
                   .where.not(users: { points: 0 })
                   .where(users: { industry: current_user["industry"] })
                   .sample

    if resume.nil?
      flash[:error] = 'No valid resumes'
      redirect_to root_path
      return
    end

    @resume = resume

    render :show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_resume
    @resume = Resume.find(params[:id])
  end

  def check_user
    return if logged_in? && @resume.user_id == current_user["id"]

    redirect_to root_path
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def resume_params
    params.require(:resume).permit(:file)
  end
end
