class DojoStudentsController < ApplicationController

  def new
    @dojo_student = DojoStudent.new
    @dojo_student.student_id = params[:student_id] unless params[:student_id].nil?
  end

  def edit
    @dojo_student = DojoStudent.new
    student_id = params[:student_id] unless params[:student_id].nil?
    @student = Student.find(student_id) unless student_id.nil?
    @dojo_students = DojoStudent.for_student(@student).chronological.paginate(:page => params[:page]).per_page(20)
  end

  def end
    @dojo_student = DojoStudent.find(params[:id])
    @dojo_student.end_date = nil
    flash[:notice] = "Successfully ended student's dojo record."
    redirect_to :back
  end


  def create
    @dojo_student = DojoStudent.new(params[:dojo_student])
    if @dojo_student.save
      flash[:notice] = "Successfully created student's dojo record."
      redirect_to :back
    else
      render :action => 'new'
    end
  end

  def update
    @dojo_student = DojoStudent.find(params[:id])
    @student = Student.find(@dojo_student.student_id)
    if @dojo_student.update_attributes(params[:dojo_student])
      flash[:notice] = "Successfully updated student's dojo record."
      redirect_to edit_dojo_student_url(:student_id => @dojo_student.student_id)
    else
      redirect_to edit_dojo_student_url(:student_id => @dojo_student.student_id)
    end
  end

  def destroy
    @dojo_student = DojoStudent.find(params[:id])
    @student = Student.find(@dojo_student.student_id)
    @dojo_student.destroy
    flash[:notice] = "Successfully destroyed student's dojo record."

    if DojoStudent.for_student(@student).size==0
      redirect_to @student
    else
      redirect_to edit_dojo_student_url(:student_id => @student.id)
    end

  end
end
