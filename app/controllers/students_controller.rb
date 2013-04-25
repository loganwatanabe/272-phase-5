class StudentsController < ApplicationController

  def index
    @students = Student.alphabetical
    @active_students = Student.active.alphabetical.paginate(:page => params[:page]).per_page(20)
    @inactive_students = Student.inactive.alphabetical.paginate(:page => params[:page]).per_page(15)
  end

  def show
    @student = Student.find(params[:id])
    @registrations = Registration.for_student(@student).by_event_name.paginate(:page => params[:page]).per_page(20)
  end

  def new
    @student = Student.new

  end

  def reg
    @student = Student.find(params[:id])
    @sections = eligible_sections_for_student(@student)
  end

  def edit
    @student = Student.find(params[:id])
  end

  def create
    @student = Student.new(params[:student])
    if @student.save
      flash[:notice] = "Successfully created #{@student.proper_name}."
      redirect_to @student # go to show student page
     else
      # return to the 'new' form
      render :action => 'new'
    end

  end


  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:notice] = "Successfully updated #{@student.proper_name}."
      redirect_to @student
    else
      render :action => 'edit'
    end
  end


  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    flash[:notice] = "Successfully removed #{@student.proper_name} from the PATS system."
    redirect_to students_url

  end



  #Custom views, to ensure correct subset is displayed

  def active
    @active_students = Student.active.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def inactive
    @inactive_students = Student.inactive.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def juniors
    @juniors = Student.juniors.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def seniors
    @seniors = Student.seniors.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def signed
    @signed = Student.has_waiver.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def unsigned
    @unsigned = Student.needs_waiver.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def dans
    @dans = Student.dans.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def gups
    @gups = Student.gups.alphabetical.paginate(:page => params[:page]).per_page(20)
  end



end
