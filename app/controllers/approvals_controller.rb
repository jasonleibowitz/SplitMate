class ApprovalsController < ApplicationController

	### The approvals are an aspect of a completed chore, therefor they do not have their own view/show/edit pages, but rather work 100% through AJAX.

	### Because of this, it makes more sense to respond with a JSON object of the chore_history object that was voted on, not the actual vote object itself.  This is because approval votes can be deleted, in which case there would be nothing to return.  It also DRY's up Javascript on frontend views because we work with only one object. ###

	def create
  	@approval = Approval.new(chore_history_id: params[:chore_history_id], value: params[:value])
  	@approval.user_id = current_user.id
  	@approval.save!
  	@chore_history = @approval.chore_history
  		respond_to do |format|
        format.html { }
        format.json { render json: @approval.to_json }
        format.js   { }
      end
  end

  def update
    @user = current_user
    approval_search = @user.approvals.select {|approval| approval.chore_history_id = params[:approval][:chore_history_id]}
    @approval = approval_search[0]
    chore_history = @approval.chore_history
  	if @approval.update(value: params[:approval][:value])
      chore_history.calculate_score
      # @chore_history.check_ratio
      respond_to do |format|
        format.html
        format.json { render json: @approval.to_json }
      end
    elsif 
      @message = "error couldn't update"
      return @message
    end
  end

  def destroy
    @user = current_user
    approval_search = @user.approvals.select {|approval| approval.chore_history_id = params[:approval][:chore_history_id]}
    @approval = approval_search[0]
  	@chore_history = @approval.chore_history
  	if @approval.destroy 
  		@chore_history.calculate_score
      # @chore_history.check_ratio
  		respond_to do |format|
	      format.html
	      format.json { render json: @approval.to_json }
	    end
  	elsif 
  		@message = "error couldn't destroy"
  		return @message
  	end
  end

  private
  # def approval_params
  # 	params.require(:approval).permit(:chore_history_id, :value)
  # end

end
