class Admins::SubjectsController < ApplicationController
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
  
  def edit
    @subject = Subject.find_by id: params[:id]
  end
  
  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "subject.update_success"
      redirect_to @subject
    else
      flash[:danger] = t "subject.update_failed"
      render edit
    end
  end
  
  private
  def subject_params
    params.require(:subject).permit :content, :number_of_questions, :duration
  end
end
