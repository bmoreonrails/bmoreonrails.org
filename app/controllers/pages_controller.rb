class PagesController < ApplicationController
  def home
    @member_list = Member.list.shuffle

  end
end
