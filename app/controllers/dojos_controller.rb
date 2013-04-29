class DojosController < ApplicationController
  def index
    @dojos = Dojo.alphabetical.paginate(:page => params[:page]).per_page(20)
    @active_dojos = Dojo.alphabetical.active.paginate(:page => params[:page]).per_page(20)
    @inactive_dojos = Dojo.alphabetical.inactive.paginate(:page => params[:page]).per_page(20)
  end

  def show
    @dojo = Dojo.find(params[:id])
    @current_students = @dojo.current_students #paginate(:page => params[:page]).per_page(20)   #This don't work cuz of the method
  end

  def show_records
    @dojo = Dojo.find(params[:id])
    @current_students = @dojo.current_students#.paginate(:page => params[:page]).per_page(20)   #This don't work cuz of the method
    @dojo_students = DojoStudent.for_dojo(@dojo).by_student.paginate(:page => params[:page]).per_page(20) # this for_dojo needs to be tested!!!
  end

  def new
    @dojo = Dojo.new
    @STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]
  
  end

  def edit
    @dojo = Dojo.find(params[:id])
    @STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]
  
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

  def active
    @active_dojos = Dojo.active.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def inactive
    @inactive_dojos = Dojo.inactive.alphabetical.paginate(:page => params[:page]).per_page(20)
  end


end
