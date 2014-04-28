class ChoreHistoriesController < ApplicationController

  def index

  end

  def show

  end

  def new
    @chore_history = ChoreHistory.all
  end

  def create
    @chore = Chore.find(session[:chore_id])
    @chore_history = ChoreHistory.new(chore_history_params)
    @chore_history.save!
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

end
