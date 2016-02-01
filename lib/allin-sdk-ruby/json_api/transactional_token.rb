module AllinSDK
  module JsonAPI
    class TransactionalToken
      def self.retrieve
        AllinSDK::JsonAPI::Facade.set_base_uri(self.transactional_uri)
        result = AllinSDK::JsonAPI::Facade.api_get(self.token_method_name, {
          username: self.username,
          password: self.password
        }, false)
        result["token"]
      end

      private
      def self.transactional_uri
        configatron.allinsdk_api_uri_transactional
      end

      def self.token_method_name
        configatron.allinsdk_api_list_transactional_token_method
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
