# frozen_string_literal: true

module Spree
  class GdprRequest < ApplicationRecord
    belongs_to :user, class_name: Spree.user_class.to_s, inverse_of: :gdpr_requests

    enum intent: {
      data_restriction: 0,
      data_erasure: 1,
      data_export: 2,
    }

    validates :intent, presence: true

    def serve
      result = case intent.to_sym
      when :data_export
        SolidusGdpr::DataExporter.new(user).run
      when :data_erasure
        SolidusGdpr::DataEraser.new(user).run
      when :data_restriction
        SolidusGdpr::DataRestrictor.new(user).run
      else
        fail NotImplementedError, "#{intent} requests cannot be served automatically"
      end

      update!(
        served_at: Time.zone.now,
        processed_segments: [result],
      )

      result
    end
  end
end
