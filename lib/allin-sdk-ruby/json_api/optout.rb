module AllinSDK
  module JsonAPI
    class Optout
      def self.insert(email)
        result = AllinSDK::JsonAPI::Facade.api_get(self.optout_insert_method_name, {
          email: email
        })
      end

      def self.remove(email)
        result = AllinSDK::JsonAPI::Facade.api_get(self.optout_remove_method_name, {
          email: email
        })
      end

      private
      def self.optout_insert_method_name
        configatron.allinsdk_api_optout_insert_method
      end

      def self.optout_remove_method_name
        configatron.allinsdk_api_optout_remove_method
      end
    end
  end
end
