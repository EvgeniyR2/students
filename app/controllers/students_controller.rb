# frozen_string_literal: true

class StudentsController < ApplicationController
  def index
    students = Student.where(user_id: current_user.id)
    @students_count = students.count
    @students = StudentsQuery.new.call(students, params)
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(create_params)

    return redirect_to students_path if @student.save

    render :new
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])

    return redirect_to students_path if @student.update(update_params)

    render :edit
  end

  def destroy
    @student = Student.find(params[:id])
    @student.delete

    redirect_to students_path
  end

  private

  def create_params
    result = permitted_params.merge(user_id: current_user.id)
    result[:identifier] = nil if result[:identifier] == ''
    result
  end

  def update_params
    result = permitted_params
    result[:identifier] = nil if result[:identifier] == ''
    result
  end

  def permitted_params
    params.require(:student).permit(:first_name, :last_name, :middle_name, :gender, :identifier)
  end
end
