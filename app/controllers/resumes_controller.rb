class ResumesController < ApplicationController
  before_action :set_resume, only: %i[show update destroy]
  before_action :check_user, only: %i[update destroy]

  # GET /resumes
  def index
    @resumes = Resume.all
  end

  # GET /resumes/1
  def show; end

  # GET /resumes/new
  def new
    @resume = Resume.new
  end

  # POST /resumes
  def create
    @resume = Resume.new(resume_params)
    @resume.user_id = current_user.id

    if @resume.save
      redirect_to resumes_path, notice: "The resume for user #{@resume.user_id} has been created."
    else
      render :new
    end

  end

  # DELETE /resumes/1
  def destroy
    @resume.destroy
    redirect_to resumes_url, notice: 'Resume was successfully deleted.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_resume
    @resume = Resume.find(params[:id])
  end

  def check_user
    return if logged_in? && @resume.user_id == current_user.id

    redirect_to root_path
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def resume_params
    params.require(:resume).permit(:file, :user_id)
  end
end
