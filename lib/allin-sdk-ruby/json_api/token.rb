module AllinSDK
  module JsonAPI
    class Token
      def self.retrieve
        result = AllinSDK::JsonAPI::Facade.api_get(self.token_method_name, {
          username: self.username,
          password: self.password
        }, false)
        result["token"]
      end

      private
      def self.token_method_name
        configatron.allinsdk_api_list_token_method
      end

      def self.username
        configatron.allinsdk_api_login
      end

      def self.password
        configatron.allinsdk_api_password
      end
    end
  end
end
