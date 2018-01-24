require 'hashie'

class Member < Hashie::Mash
  def self.list
    MEMBER_CONFIG.map(&method(:new))
  end

  def avatar_file_path
    "members/#{avatar_file}" if avatar_file.present?
  end

  def twitter_url
    "http://twitter.com/#{twitter}" if twitter.present?
  end

  def github_url
    "http://github.com/#{github_name}" if github_name.present?
  end
end
