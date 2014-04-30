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
    @chore = Chore.new(chore_params)
    @apartment = Apartment.find(params[:apartment_id])
    @chore.apartment = @apartment
    @chore.dollar_value = 0
    if @chore.valid?
      @chore.save
      redirect_to @apartment
    else
      render 'new'
    end
  end

  def edit
    @chore = Chore.find(params[:id])
  end

  def update
    @chore = Chore.find(params[:id])
    @chore.update(chore_params)
    redirect_to @chore.apartment
  end

  def destroy
    @chore = Chore.find(params[:id])
    @chore.destroy
  end

  def assign_chore
    @chore = Chore.find(params[:id])
    @user = current_user

    @chore.assign_chore(@user)

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
    @comments = params[:comments]
    @chore.complete_chore(@comments)
    redirect_to @user
  end

  def last_week
    @user = User.find_by_email(params[:user])
    @sorted_chore_histories = @user.chore_histories.order(created_at: :desc).where "created_at > ?", 1.week.ago

    respond_to do |format|
      format.html { }
      format.json { render json: @sorted_chore_histories.to_json }
    end
  end

  def last_month
    @user = User.find_by_email(params[:user])
    @sorted_chore_histories = @user.chore_histories.order(created_at: :desc).where "created_at > ?", 4.weeks.ago
    respond_to do |format|
      format.html { }
      format.json { render json: @sorted_chore_histories }
    end
  end

  private

  def chore_params
    return params.require(:chore).permit(:name, :points_value, :due_date)
  end

end

