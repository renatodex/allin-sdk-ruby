module AllinSDK
  module JsonAPI
    class ListEmail
      extend Helpers::Builder

      def self.insert(list, email, merge_data)
        fields = self.build_fields({nm_email: email}.merge(merge_data))
        values = self.build_values({nm_email: email}.merge(merge_data))

        AllinSDK::JsonAPI::Facade.api_post(self.insert_method_name, {
          "dados_email" => {
            "nm_lista" => list,
            "campos" => fields,
            "valor" => values
          }.to_json
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
