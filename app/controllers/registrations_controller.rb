class RegistrationsController < ApplicationController
  
  def index
    @registrations = Registration.by_date
  end

  def show
    #get information for this registration
    @registration = Registration.find(params[:id])
  end


  def new
    @registration = Registration.new
    @registration.student_id = params[:student_id] unless params[:student_id].nil?    #assigns foreign keys passed in
    @registration.section_id = params[:section_id] unless params[:section_id].nil?

    @student = Student.find(@registration.student_id) unless @registration.student.nil? #if student was passed in
    #@sections = eligible_sections_for_student(@student).paginate(:page => params[:page]).per_page(20) unless @registration.student.nil?


    @section = Section.find(@registration.section_id) unless @registration.section.nil? #if section was passed in
    #@students = eligible_students_for_section(@section).paginate(:page => params[:page]).per_page(20) unless @registration.section.nil?

  end


  def edit
    @registration = Registration.find(params[:id])  #should not be able to edit registrations anyways
  end

  def create
    @registration = Registration.new(params[:registration])
    if @registration.save
      flash[:notice] = "Successfully registered #{@registration.student.name} for section."
      redirect_to :back  #I want to stay on the same registration page, so the change can be reflected
    else
      redirect_to :back
    end
  end

  def update
    @registration = Registration.find(params[:id])
    if @registration.update_attributes(params[:registration])
      flash[:notice] = "Successfully updated registration for #{@registration.student.name} for section."
      redirect_to @registration
    else
      render :action => 'edit'
    end
  end

  def destroy
    
    @registration = Registration.find(params[:id])

    @registration.destroy
    flash[:notice] = "Successfully destroyed registration for #{@registration.student.name} for #{@registration.section.event.name} section."
    redirect_to :back
  end


end