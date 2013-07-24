module ApplicationHelper
  # Returns true if the current request is made from a mobile browser
  def mobile?
    return @mobile if defined? @mobile
    @mobile = request.user_agent =~ /palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|mobile/i
    @mobile = @mobile && request.user_agent !~ /iPad/
  end

  def member_pixel(index)
    member = Member.member(index)
    
  end
end
