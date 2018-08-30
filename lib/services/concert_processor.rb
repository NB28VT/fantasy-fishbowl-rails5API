class ConcertProcessor
  def initialize(concert)
    @concert = concert
    @setlist_data = []
  end

  def process
    get_setlist
    build_setlist
    score_predictions
  end

  private

  def get_setlist
    raw_data = ConcertDataClient.new(@concert).pull_setlist
    parsed_data = JSON.parse(raw_data)
    raise "Error Pulling Setlist: #{parsed_data["error_message"]}" if parsed_data["error_message"]
    raise "Setlist Not Found" if parsed_data.dig("response", "count") == 0
    @setlist_data = SetListParser.new(raw_data).parse
  end

  def build_setlist
    # Loop through setlists and assign data to concerts
  end
end
