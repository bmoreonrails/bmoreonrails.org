class SlackController < ApplicationController
  def invite
    response = HTTParty.post(slack_url, body: {email: params[:email],
                                               token: slack_token,
                                               set_active: true})
    if response.response.code  == 200
      body = JSON.parse(response.body)
      if body["ok"]
        flash[:info] = 'Awesome, check your email for an invite!'
      elsif body["error"] == 'already_invited'
        flash[:error] = 'Yikes, looks like you were already invited... check your email.'
      else
        flash[:error] = 'Hmmm, looks like something went terribly wrong. Ping @bmoreonrails for help.'
      end
    else
      flash[:error] = 'Hmmm, looks like something went terribly wrong'
    end

    redirect_to root_path
  end

  private

  def slack_url
    "https://#{ENV['SLACK_URL']}/api/users.admin.invite"
  end

  def slack_token
    ENV['SLACK_TOKEN']
  end
end
