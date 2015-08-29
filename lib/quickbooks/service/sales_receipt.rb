module Quickbooks
  module Service
    class SalesReceipt < BaseService

      def delete(sales_receipt)
        delete_by_query_string(sales_receipt)
      end
      
      def mail(sales_receipt_id, email_address=nil)
          query = email_address.present? ? "?sendTo=#{email_address}" : ""
          url = "#{url_for_resource(model::REST_RESOURCE)}/#{sales_receipt_id}/send#{query}"
          response = do_http_post(url,{})
          if response.code.to_i == 200
              model.from_xml(parse_singular_entity_response(model, response.plain_body))
              else
              nil
          end
      end

      private

      def model
        Quickbooks::Model::SalesReceipt
      end
    end
  end
end
