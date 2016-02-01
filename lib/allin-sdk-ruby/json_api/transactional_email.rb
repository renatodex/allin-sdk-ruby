module AllinSDK
  module JsonAPI
    class TransactionalEmail
      extend Helpers::Builder

      def self.send(send_info, merge_data)
        TransactionalEmail.class_eval do |c|
          def self.generate_token
            puts 123
            AllinSDK::JsonAPI::TransactionalToken.retrieve
          end
        end

        fields = self.build_fields({}.merge(merge_data))
        values = self.build_values({}.merge(merge_data))

        AllinSDK::JsonAPI::Facade.set_base_uri(self.transactional_uri)
        result = AllinSDK::JsonAPI::Facade.api_post(self.send_method_name, {
          "dados_email" => {
            "nm_email" => send_info[:receiver_email] || "",
            "html_id" => send_info[:template_id] || "",
            "nm_subject" => send_info[:subject] || "",
            "nm_remetente" => send_info[:sender_name] || "",
            "email_remetente" => send_info[:sender_email] || "",
            "nm_reply" => send_info[:sender_email] || "",
            "dt_envio" => send_info[:dt_envio] || Date.today.strftime("%Y-%m-%d"),
            "hr_envio" => send_info[:hr_envio] || Time.now.strftime("%H:%I"),
            "campos" => fields,
            "valor" => values
          }.to_json
        })
        result
      end

      private
      def self.transactional_uri
        configatron.allinsdk_api_uri_transactional
      end

      def self.send_method_name
        configatron.allinsdk_api_transactionemail_method
      end
    end
  end
end
