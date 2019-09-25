# frozen_string_literal: true

module SolidusGdpr
  module Serializers
    # @api private
    class ProfileSerializer < BaseSerializer
      def as_json(*)
        return unless object

        {
          email: object.email,
          sign_in_count: object.sign_in_count,
          last_request_at: object.last_request_at,
          current_sign_in_at: object.current_sign_in_at,
          last_sign_in_at: object.last_sign_in_at,
          current_sign_in_ip: object.current_sign_in_ip,
          last_sign_in_ip: object.last_sign_in_ip,
          login: object.login,
          created_at: object.created_at,
          updated_at: object.updated_at,
          confirmed_at: object.confirmed_at,
          data_processable: object.data_processable,
          ship_address: serialize(object.ship_address, with: :address),
          bill_address: serialize(object.bill_address, with: :address),
        }
      end
    end
  end
end
