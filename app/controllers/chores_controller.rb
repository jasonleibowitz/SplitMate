class ChoresController < ApplicationController

  def index
    @chores = Chore.all
  end

  def show
    @chore = Chore.find(params[:id])
  end

  def new
    @chore = Chore.new
    @apartment = Apartment.find(params[:apartment_id])
  end

  def create
    @chore = Chore.create(chore_params)
    @apartment = Apartment.find(params[:apartment_id])
    @chore.apartment = @apartment
    @chore.save!
    redirect_to @apartment
  end

  def edit
    @chore = Chore.find(params[:id])
  end

  def update
    @chore = Chore.find(params[:id])
    @chore.update(chore_params)
  end

  def destroy
    @chore = Chore.find(params[:id])
    @chore.destroy
  end

  def assign_chore
    @chore = Chore.find(params[:id])
    @user = current_user
    @chore.user = @user
    @chore.save!
    redirect_to @user
  end

  def chore_completed_details
    respond_to do |format|
      format.html { }
      format.js { }
    end
  end

  def complete_chore
    @chore = Chore.find(params[:chore_id])
    @user = @chore.user
    require_authorization
    # Mark chore as unassigned
    @chore.user = nil
    @chore.save!

    # Give user points for completing chore
    @user.update_points(@chore.points_value)
    @user.save!

    # Create a new chore history after user completed chore
    @chore_history = ChoreHistory.new
    @chore_history.comments = params[:comments]
    @chore_history.chore = @chore
    @chore_history.name = @chore.name
    @chore_history.points_value = @chore.points_value
    @chore_history.user = @user
    @chore_history.apartment = @user.apartment
    @chore_history.save!

    redirect_to @user
  end

  private

  def chore_params
    return params.require(:chore).permit(:name, :points_value, :due_date)
  end

end

