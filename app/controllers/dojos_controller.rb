class DojosController < ApplicationController
  def index
    @dojos = Dojo.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def show
    @dojo = Dojo.find(params[:id])
    @current_students = @dojo.current_students#.paginate(:page => params[:page]).per_page(20)   #This don't work cuz of the method
    @dojo_students = DojoStudent.for_dojo(@dojo).by_student.paginate(:page => params[:page]).per_page(20) # this for_dojo needs to be tested!!!
  end

  def new
    @dojo = Dojo.new
    @STATES_LIST = ['AL','AK','AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT', 'VA', 'WA','WV','WI','WY']
  
  end

  def edit
    @dojo = Dojo.find(params[:id])
  end




  def create
    @dojo = Dojo.new(params[:dojo])
    if @dojo.save
      flash[:notice] = "Successfully created #{@dojo.name}."
      redirect_to @dojo
    else
      render :action => 'new'
    end
  end

  def update
    @dojo = Dojo.find(params[:id])
    if @dojo.update_attributes(params[:dojo])
      flash[:notice] = "Successfully updated #{@dojo.name}."
      redirect_to @dojo
    else
      render :action => 'edit'
    end
  end

  def destroy
    @dojo = Dojo.find(params[:id])
    @dojo.destroy
    flash[:notice] = "Successfully destroyed #{@dojo.name}."
    redirect_to dojos_url
  end

  def active
    @active_dojos = Dojo.active.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def inactive
    @inactive_dojos = Dojo.inactive.alphabetical.paginate(:page => params[:page]).per_page(20)
  end


end
