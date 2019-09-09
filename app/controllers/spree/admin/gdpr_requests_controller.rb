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

      def serve
        unless @object
          redirect_to admin_gdpr_requests_path, flash: { error: t('gdpr.exports.error') }
          return
        end

        @object.serve
        redirect_to admin_gdpr_requests_path, notice: t('gdpr.exports.scheduled')
      end

      private

      def collection
        served_at_cond = 'served_at IS NOT NULL'
        served_at_cond = Arel.sql(served_at_cond) if Arel.respond_to?(:sql)

        @collection ||=
          Spree::GdprRequest
          .order(served_at_cond, created_at: :desc)
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
