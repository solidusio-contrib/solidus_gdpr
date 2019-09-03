# frozen_string_literal: true

module Spree
  module Admin
    class GdprRequestsController < ResourceController
      helper GdprRequestsHelper

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
    end
  end
end
