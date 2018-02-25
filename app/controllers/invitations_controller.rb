class InvitationsController < ApplicationController
  def edit
    @invitation = Invitation.find_by(id: params[:id], user: current_user)
    if @invitation.accepted?
      flash[:warning] = "you have already accepted the invitation"
      redirect_to root_path
    end
  end

  def update
    if Invitation.find(params[:id]).update_attributes(invitation_params)
      Invitation.find(params[:id]).update_attributes(accepted: true)
      flash[:success] = "successfuly inputed guess and accepts invitation"
      redirect_to root_path
    else 
      render 'new'
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:guest_count)
  end
end
