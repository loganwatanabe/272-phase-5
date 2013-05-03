class DojosController < ApplicationController

  before_filter :check_login, :only => [:edit, :update, :new, :create, :show_records, :destroy]
  authorize_resource


  def index
    @dojos = Dojo.alphabetical.paginate(:page => params[:page]).per_page(20)
    @active_dojos = Dojo.alphabetical.active.paginate(:page => params[:page]).per_page(20)
    @inactive_dojos = Dojo.alphabetical.inactive.paginate(:page => params[:page]).per_page(20)
  end

  def show
    @dojo = Dojo.find(params[:id])
    @current_students = @dojo.current_students #paginate(:page => params[:page]).per_page(20)   #This don't work cuz of the method
    # @current_students = Student.alphabetical.select{|s| s.current_dojo == @dojo}.paginate(:page => params[:page]).per_page(20)
  end

  def new
    @dojo = Dojo.new
  
  end

  def edit
    @dojo = Dojo.find(params[:id])
  
  end




  def create
    @dojo = Dojo.new(params[:dojo])
    if @dojo.save
      flash[:notice] = "Successfully created #{@dojo.name} dojo."
      redirect_to @dojo
    else
      render :action => 'new'
    end
  end

  def update
    @dojo = Dojo.find(params[:id])
    if @dojo.update_attributes(params[:dojo])
      flash[:notice] = "Successfully updated #{@dojo.name} dojo."
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

#custom pages

  def active
    @active_dojos = Dojo.active.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def inactive
    @inactive_dojos = Dojo.inactive.alphabetical.paginate(:page => params[:page]).per_page(20)
  end


end
