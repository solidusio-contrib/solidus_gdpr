# frozen_string_literal: true

module SolidusGdpr
  module Spree
    module Api
      module UsersControllerDecorator
        include SerializerAware

        def emails
          emails = ::Spree::Email.where(params[:q])

          @users = { users: emails.items, more: emails.more? }
          respond_with(@users)
        end

        ::Spree::Api::UsersController.prepend self
      end
    end
  end
end
