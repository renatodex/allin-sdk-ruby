module AllinSDK
  module JsonAPI
    class Facade
      include ::HTTParty
      base_uri configatron.allinsdk_api_uri
      default_params ({
        :token => configatron.allinsdk_api_token,
        :output => "json"
      })

      def self.parse_response(response)
        begin
          JSON.parse(response)
        rescue JSON::ParserError => e
          response
        end
      end

      def self.api_get(method, params={})
        puts "[GET] starting request to Allin at \##{method} with params: #{params}".light_blue

        uri_params = ::Addressable::URI.new
        uri_params.query_values = params

        result = self.send("get", "/allinapi?method=#{method}&#{uri_params.query}", {})
        puts "[GET] request response from backend: #{result}".green
        self.parse_response result.body
      end

      def self.api_post(method, params={})
        puts "[POST] starting request to Allin at \##{method} with params: #{params}".light_blue
        result = self.send("post", "/allinapi?method=#{method}", params)
        puts "[POST] request response from backend: #{result}".green
        self.parse_response result.body
      end
    end
  end
end
