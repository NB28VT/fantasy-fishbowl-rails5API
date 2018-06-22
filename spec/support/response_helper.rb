module Support
  module ResponseHelper
    def json
      JSON.parse(response.body)
    end
  end
end
