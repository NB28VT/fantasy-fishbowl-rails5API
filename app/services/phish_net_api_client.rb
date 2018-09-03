class PhishNetConnectionError < StandardError; end

class PhishNetApiClient
  def initialize
    @api_key = ENV['PHISH_NET_API_KEY']
  end

  def api_get(endpoint, params)
    url = base_url + endpoint + "?apikey=#{@api_key}" + url_params(params)
    response = Curl::Easy.perform(url)
    raise PhishNetConnectionError, "Error in get response: #{response.response_code}, #{response.body_str}" if response.response_code != 200

    return {code: response.response_code, body: reponse.body_str}
  end

  private

  def base_url
    "https://api.phish.net/v3/"
  end

  def url_params(params)
    params.any? ? "&" + params.to_query : ""
  end
end
