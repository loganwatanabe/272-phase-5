class DojoStudentsController < ApplicationController

  def new
    @dojo_student = DojoStudent.new
  end

  def edit
    @dojo_student = DojoStudent.find(params[:id])
  end




  def update
    @dojo_student = DojoStudent.new(params[:dojo_student])
    if @dojo_student.save
      flash[:notice] = "Successfully created student's dojo record."
      redirect_to :back
    else
      render :action => 'new'
    end
  end

  def create
    @dojo_student = DojoStudent.find(params[:id])
    if @dojo_student.update_attributes(params[:dojo_student])
      flash[:notice] = "Successfully updated student's dojo record."
      redirect_to :back
    else
      render :action => 'edit'
    end
  end

  def destroy
    @dojo_student = DojoStudent.find(params[:id])
    @dojo_student.destroy
    flash[:notice] = "Successfully destroyed student's dojo record."
    redirect_to :back
  end
end
