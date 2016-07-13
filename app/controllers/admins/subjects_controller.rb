class Admins::SubjectsController < ApplicationController
  load_and_authorize_resource

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "subject.add_success"
      redirect_to admins_subjects_path
    else
      flash[:danger] = t "subject.add_fail"
      render "new"
    end
  end

  private
  def subject_params
    params.require(:subject).permit :content, :number_of_questions, :duration
  end
end
