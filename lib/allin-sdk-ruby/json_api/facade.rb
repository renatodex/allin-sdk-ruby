module AllinSDK
  module JsonAPI
    class Facade
      include ::HTTParty
      base_uri configatron.allinsdk_api_uri
      default_params ({
        :output => "json"
      })

      def self.parse_response(response)
        begin
          JSON.parse(response)
        rescue JSON::ParserError => e
          response
        end
      end

      def self.api_get(method, params={}, token_required=true)
        query_values = params
        if token_required
          query_values.merge!({token: self.generate_token})
        end

        uri_params = ::Addressable::URI.new
        uri_params.query_values = query_values

        puts "[GET] <- starting request to Allin at \##{method} with params: #{params}".light_blue
        result = self.send("get", "/allinapi/?method=#{method}&#{uri_params.query}", {})
        puts "[GET] -> request response from backend: #{result}".green
        self.parse_response result.body
      end

      def self.api_post(method, body_params={}, query_params={})
        options = {
          :body => body_params,
          :query => {token: self.generate_token}.merge(query_params),
          :headers => {
             'Cache-Control' => 'no-cache'
          }
        }

        puts "[POST] <- starting request to Allin at \##{method} with params: #{body_params}".light_blue
        result = self.send("post", "/allinapi/?method=#{method}", options)
        puts "[POST] -> request response from backend: #{result}".green

        self.parse_response result.body
      end

      def self.generate_token
        AllinSDK::JsonAPI::Token.retrieve
      end
    end
  end
end
