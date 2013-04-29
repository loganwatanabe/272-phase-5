class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.chronological.paginate(:page => params[:page]).per_page(20)
    @upcoming_tournaments = Tournament.upcoming.chronological.paginate(:page => params[:page]).per_page(20)
    @past_tournaments = Tournament.past.chronological.paginate(:page => params[:page]).per_page(20)
  end

  def show
    @tournament = Tournament.find(params[:id])
    @sections = Section.for_tournament(@tournament).paginate(:page => params[:page]).per_page(20)
  end

  def new
    @tournament = Tournament.new
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end




  def create
    @tournament = Tournament.new(params[:tournament])
    if @tournament.save
      flash[:notice] = "Successfully created #{@tournament.name}."
      redirect_to @tournament
    else
      render :action => 'new'
    end
  end
  
  
  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update_attributes(params[:tournament])
      flash[:notice] = "Successfully updated #{@tournament.name}."
      redirect_to @tournament
    else
      render :action => 'edit'
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy
    flash[:notice] = "Successfully destroyed #{@tournament.name}."
    redirect_to tournaments_url
  end


  def active
    @tournaments = Tournament.active.chronological.paginate(:page => params[:page]).per_page(20)
  end

  def inactive
    @tournaments = Tournament.inactive.chronological.paginate(:page => params[:page]).per_page(20)
  end

  def past
    @tournaments = Tournament.past.chronological.paginate(:page => params[:page]).per_page(20)
  end

  def upcoming
    @tournaments = Tournament.current.chronological.paginate(:page => params[:page]).per_page(20)
  end

end
