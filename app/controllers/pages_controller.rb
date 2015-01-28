class PagesController < ApplicationController
  def home
    @members = weighted_shuffle(Member.list)
    @meetups = Meetup.upcoming.limit(3)
  end

  def weighted_shuffle(array)
    array.sort_by { |person|
      weight = person[:list_weight] || 0.3
      weight * rand
    }
  end
end
