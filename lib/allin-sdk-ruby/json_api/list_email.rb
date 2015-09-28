module AllinSDK
  module JsonAPI
    class ListEmail
      extend Helpers::Builder

      def self.insert(list, email, merge_data)
        AllinSDK::JsonAPI::Facade.api_post(self.insert_method_name, {
          "nm_lista" => list,
          "nm_email" => email,
          "campos" => self.build_fields(merge_data),
          "valor" => self.build_values(merge_data)
        })
      end

      def self.remove(list, email)
        AllinSDK::JsonAPI::Facade.api_get(self.remove_method_name, {
          "nm_lista" => list,
          "email" => email
        })
      end

      private
      def self.insert_method_name
        configatron.allinsdk_api_list_email_insert_method
      end

      def self.remove_method_name
        configatron.allinsdk_api_list_email_remove_method
      end
    end
  end
end
