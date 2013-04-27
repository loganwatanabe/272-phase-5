class UsersController < ApplicationController
  def new
    @user = User.new
    @student = Student.find(@user.student_id) unless @user.student.nil? #these are passed in, but only one
  end


  def edit
    @user = user.find(params[:id])
  end

  def create
    @user = user.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully created account for #{@user.student.name}."
      redirect_to :back  #I want to stay on the same student page, so the change can be reflected
    else
      redirect_to :back
    end
  end

  def update
    @user = user.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated account for #{@user.student.name}."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    
    @user = user.find(params[:id])

    @user.destroy
    flash[:notice] = "Successfully destroyed user account for #{@user.student.name}."
    redirect_to :back
  end

end
