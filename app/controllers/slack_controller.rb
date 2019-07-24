class SlackController < ApplicationController
  def invite
    invite = SlackInvite.new(email: params[:email])
    
    if verify_recaptcha(model: invite)
      if invite.deliver
        flash[:info] = 'Awesome, check your email for an invite!'
      else
        flash[:error] = invite.errors.full_messages.to_sentence
      end
    else
      flash[:error] = 'Sorry, you need to tell us you are not a robot to join our slack!'
    end

    redirect_to root_path
  end
end
