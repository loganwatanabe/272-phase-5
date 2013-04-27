class DojosController < ApplicationController
  def index
    @dojos = Dojo.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def show
    @dojo = Dojo.find(params[:id])
    @students = @dojo.current_students
  end

  def new
    @dojo = Dojo.new
  end

  def edit
    @dojo = Dojo.find(params[:id])
  end




  def update
    @dojo = Dojo.new(params[:dojo])
    if @dojo.save
      flash[:notice] = "Successfully created #{@dojo.name}."
      redirect_to @dojo
    else
      render :action => 'new'
    end
  end

  def create
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
end
