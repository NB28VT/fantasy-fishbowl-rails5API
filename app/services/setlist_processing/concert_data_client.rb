require 'net/http'
require 'dotenv'
Dotenv.load

module SetlistProcessing
  class ConcertDataClient
    def initialize(concert)
      @concert = concert
    end

    def pull_setlist
      endpoint = "https://api.phish.net/v3/setlists/get?"
      endpoint += "apikey=#{ENV['PHISH_NET_API_KEY']}"
      endpoint += "&showdate=#{formatted_show_time}"
      return Net::HTTP.get(URI(endpoint))
    end

    private

    def formatted_show_time
      @concert.show_time.strftime('%F')
    end
  end
end
