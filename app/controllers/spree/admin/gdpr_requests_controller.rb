# frozen_string_literal: true

module Spree
  module Admin
    class GdprRequestsController < ResourceController
      include GdprRequestsHelper
      helper GdprRequestsHelper

      before_action :load_data

      def index
        respond_with(@collection)
      end

      private

      def collection
        @collection ||=
          Spree::GdprRequest
            .order('served_at IS NOT NULL', created_at: :desc)
            .page(params[:page] || 0)
      end

      def load_data
        @users = Spree::User.order(:email)
        @intents = Spree::GdprRequest.intents.collect do |slug, _index|
          [title_case(slug), slug]
        end
      end
    end
  end
end
