module Request
  module JsonHelpers
    def json_response(memoized=false)
      if memoized
        @json_response ||= parse_response
      else
        parse_response
      end
    end

    def parse_response
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
