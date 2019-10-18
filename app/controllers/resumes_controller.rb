class ResumesController < ApplicationController
  before_action :set_resume, only: %i[show edit update destroy]
  before_action :check_user, only: %i[show edit update destroy]

  # GET /resumes
  # GET /resumes.json
  def index
    @resumes = Resume.all.filter { |resume| resume.user_id == current_user.id }
  end

  # GET /resumes/1
  # GET /resumes/1.json
  def show; end

  # GET /resumes/new
  def new
    @resume = Resume.new
  end

  # GET /resumes/1/edit
  def edit; end

  # POST /resumes
  # POST /resumes.json
  def create
    @resume = Resume.new(resume_params)
    @resume.user_id = current_user.id

    if @resume.save
      redirect_to resumes_path, notice: "The resume for user #{@resume.user_id} has been created."
    else
      render :new
    end

  end

  # PATCH/PUT /resumes/1
  # PATCH/PUT /resumes/1.json
  def update
    respond_to do |format|
      if @resume.update(resume_params)
        format.html { redirect_to @resume, notice: 'Resume was successfully updated.' }
        format.json { render :show, status: :ok, location: @resume }
      else
        format.html { render :edit }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.json
  def destroy
    @resume.destroy
    respond_to do |format|
      format.html { redirect_to resumes_url, notice: 'Resume was successfully destroyed.' }
      format.json { head :no_content }
    end
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
    params.require(:resume).permit(:file_content, :user_id)
  end
end
