class SlackInvite
  include ActiveModel::Model
  
  attr_accessor :email
  validates_presence_of :email

  ERROR_MSG = 'Hmmm, looks like something went terribly wrong. Ping @bmoreonrails for help.'

  def deliver
    return unless valid?

    response = HTTParty.post(slack_url, body: {email: email,
                                               token: slack_token,
                                               set_active: true})

    if response.response.code == '200'
      body = JSON.parse(response.body)
      if !body["ok"]
        if body["error"] == 'already_invited'
          errors.add(:base, 'Yikes! Looks like you were already invited... check your email.')
        else
          errors.add(:base, ERROR_MSG)
        end
        return false
      end
      return true
    else
      errors.add(:base, ERROR_MSG)
      return false
    end
  rescue Exception => e
    errors.add(:base, ERROR_MSG)
    return false
  end

  private

  def slack_url
    "https://#{ENV['SLACK_URL']}/api/users.admin.invite"
  end

  def slack_token
    ENV['SLACK_TOKEN']
  end
end
