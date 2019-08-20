# frozen_string_literal: true

module SolidusGdpr
  module Spree
    module UserDecorator
      def self.prepended(base)
        base.has_many :gdpr_requests, class_name: 'Spree::GdprRequest', inverse_of: :user

        base.scope :data_processable, -> { where data_processable: true }
        base.scope :data_restricted, -> { where data_processable: false }
      end

      ::Spree::User.prepend self
    end
  end
end
