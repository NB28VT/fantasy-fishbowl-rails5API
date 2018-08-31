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
      endpoint += "&showdate=#{@concert.show_time}"
      return Net::HTTP.get(URI(endpoint))
    end
  end
end
