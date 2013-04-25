class SectionsController < ApplicationController
  
  def index
    #get all sections
    @sections = Section.alphabetical.paginate(:page => params[:page]).per_page(20)
    @active_sections = Section.active.alphabetical.paginate(:page => params[:page]).per_page(20)
    @inactive_sections = Section.inactive.alphabetical.paginate(:page => params[:page]).per_page(20)
    @students = Student.all
  end

  def show
    @section = Section.find(params[:id])
    @registrations = Registration.for_section(@section).by_student.paginate(:page => params[:page]).per_page(20)
  end

  def new
    @section = Section.new
    @events = Event.active.alphabetical #need this so that the Events will be ordered in the form dropdown
  end

  def reg
    @section = Section.find(params[:id])
    @students = eligible_students_for_section(@section)
  end

  def edit
    @section = Section.find(params[:id])
    @events = Event.active.alphabetical #need this so that the Events will be ordered in the form dropdown
  end

  
  def create
    @section = Section.new(params[:section])
    if @section.save
      flash[:notice] = "Successfully created section."
      redirect_to @section
    else
      render :action => 'new'
    end
  end
  
  
  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(params[:section])
      flash[:notice] = "Successfully updated section."
      redirect_to @section
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    flash[:notice] = "Successfully destroyed section."
    redirect_to sections_url
  end

  #Custom page views, needed so that correct subsets are passed into the view

  def active
    @active_sections = Section.active.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def inactive
    @inactive_sections = Section.inactive.alphabetical.paginate(:page => params[:page]).per_page(20)
  end





end