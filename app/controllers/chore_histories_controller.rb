class ChoreHistoriesController < ApplicationController

  def index

  end

  def show
    @chore_history = ChoreHistory.find(params[:id])
  end

  def new
    @chore_history = ChoreHistory.all
  end

  def create
    @chore = Chore.find(params[:chore_id])
    @comments = params[:comments]
    @user = @chore.user

    @chore.complete_chore(@comments)

    # Create new chore history object
    @chore_history = ChoreHistory.new(chore_hist_params)
    @chore_history.name = @chore.name
    @chore_history.points_value = @chore.points_value
    @chore_history.user = @user
    @chore_history.apartment = @user.apartment
    @chore_history.approval_points = 0
    @chore_history.approval_ratio = 0
    @chore_history.approved = true
    @chore_history.save!
    @chore_history.js_date = @chore_history.created_at.to_i
    @chore_history.save!

    redirect_to @chore_history
  end

  def edit
    @chore_history = ChoreHistory.find(params[:id])
  end

  def update
    @chore_history = ChoreHistory.find(params[:id])
    @chore_history.update(chore_history_params)
  end

  def destroy

  end

  private
  def chore_hist_params
    return params.permit(:comments, :avatar, :after_picture, :chore_id)
  end

end
