module SetlistProcessing
  class SetlistValidator
    def initialize(concert_json)
      @concert_json = concert_json
    end

    def validate
      raise ApiParseError, "Phish.net Error Message: #{@concert_json["error_message"]}" if error_message?
      raise ApiParseError, "Empty Search Results" if empty_search_results?
      raise ApiParseError, "Empty Response Data" if empty_response_data?
      raise ApiParseError, "Missing Setlist Data" if missing_setlist_data?
    end

    private

    def error_message?
      @concert_json["error_message"].present?
    end

    def empty_search_results?
      @concert_json["response"]["count"] == 0
    end

    def empty_response_data?
      @concert_json.dig("response", "data").blank?
    end

    def missing_setlist_data?
      @concert_json.dig("response", "data").find{|data| data.has_key?("setlistdata")}.nil?
    end
  end
end
