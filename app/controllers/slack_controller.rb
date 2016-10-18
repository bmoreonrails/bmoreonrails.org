class SlackController < ApplicationController
  def invite
    invite = SlackInvite.new(email: params[:email])
    
    if invite.deliver
      flash[:info] = 'Awesome, check your email for an invite!'
    else
      flash[:error] = invite.errors.full_messages.to_sentence
    end

    redirect_to root_path
  end
end
