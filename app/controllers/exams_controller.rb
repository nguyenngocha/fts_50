class ExamsController < ApplicationController
  load_and_authorize_resource
  before_action :check_subject, only: [:create]

  def index
    @subjects = Subject.all 
    @exam = Exam.new
    @exams = current_user.exams
  end

  def new
  end

  def show
    if @exam.start?
      @time_start = Time.now.to_i
      @exam.update_attributes time_start: @time_start, status: :testing
    else
      @time_start = @exam.time_start
    end
  end

  def create
    @exam = current_user.exams.build exam_params
    if @exam.save
      flash[:sucess] = t "flash.created_xam_success"
    else
      flash[:danger] = t "flash.created_xam_failed"
    end
    redirect_to exams_path
  end

  def update
    @exam.status = case params[:commit]
      when "Finish" then :unchecked
      when "Checked" then :checked
      else :saved
    end
    @exam.time_end = Time.now.to_i

    if @exam.update_attributes exam_params
      flash.now[:success] = t "flashs.finished" 
      if @exam.checked? && current_user.admin?
        redirect_to admin_exams_path
      else
        redirect_to exams_path
      end     
    else
      flash.now[:danger] = t "flashs.error_finished"
    end
  end

  private
  def exam_params
    params.require(:exam).permit :subject_id, :status,
      results_attributes: [:id, :answer_id]      
  end

  def check_subject
    @subject = Subject.find params[:exam][:subject_id]
    if @subject.questions.size < 1
      flash.now[:danger] = t "flashs.subject_no_question"
      redirect_to exams_path
    end
  end
end
