class Meetup < ActiveRecord::Base
  UPCOMING_EVENTS_URL = 'http://api.meetup.com/2/events?group_id=347566&status=upcoming&order=time&limited_events=False&desc=false&offset=0&format=json&page=20&fields=&time=%2C5w&sig_id=9347737&sig=f6274cfd7bf5c34df7ec77400585d13b00a0666e'

  scope :upcoming, -> { where('time > now()').order('time ASC') }

  def clean_description
    return '' unless description
    Sanitize.clean(description)
  end

  def google_map_url
    URI::encode("https://maps.google.com/maps?ie=UTF8&q=#{venue_lat},#{venue_lon}&z=18")
  end

  def self.update
    fetch_upcoming_meetups.each do |api_meetup|
      api_venue = api_meetup['venue']
      new_meetup = Meetup.find_or_initialize_by(remote_id: api_meetup['id'])
      new_meetup.update_attributes(
        event_url: api_meetup['event_url'],
        description: api_meetup['description'],
        how_to_find_us: api_meetup['how_to_find_us'],
        name: api_meetup['name'],
        time: Time.at(api_meetup['time'].to_i/1000),
        venue_name: api_venue['name'],
        venue_address_1: api_venue['address_1'],
        venue_address_2: api_venue['address_2'],
        venue_city: api_venue['city'],
        venue_state: api_venue['state'],
        venue_zip: api_venue['zip'],
        venue_lat: api_venue['lat'],
        venue_lon: api_venue['lon']
      )
    end
  end

  def self.fetch_upcoming_meetups
    response = api_connection.get(UPCOMING_EVENTS_URL).body
    JSON.parse(response)['results']
  end

  def self.api_connection
    @connection ||= Faraday.new(url: 'https://api.meetup.com') do |faraday|
      faraday.adapter  Faraday.default_adapter
      faraday.response :logger
    end
  end
end
