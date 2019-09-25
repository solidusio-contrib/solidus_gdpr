# frozen_string_literal: true

module Spree
  class GdprRequest < ApplicationRecord
    enum intent: {
      data_restriction: 0,
      data_erasure: 1,
      data_export: 2,
      resume_processing: 3
    }

    validates :intent, presence: true
    validates :email, presence: true

    after_create :after_create

    def serve
      result = case intent.to_sym
      when :data_export
        SolidusGdpr::DataExporter.new(email).run
      when :data_erasure
        SolidusGdpr::DataEraser.new(email).run
      when :data_restriction
        SolidusGdpr::DataRestrictor.new(email).run
      when :resume_processing
        SolidusGdpr::DataRestrictor.new(email).rollback
      else
        fail NotImplementedError, "#{intent} requests cannot be served automatically"
      end

      update!(
        served_at: Time.zone.now,
        processed_segments: [result],
      )

      after_serve
      result
    end

    private

    def after_create
      Spree::Event.fire 'gdpr_request_created' if defined? Spree::Event

      # otherwise noop, overwrite me in your app
    end

    def after_serve
      Spree::Event.fire 'gdpr_request_served' if defined? Spree::Event

      # otherwise noop, overwrite me in your app
    end
  end
end
