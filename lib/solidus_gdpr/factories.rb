# frozen_string_literal: true

FactoryBot.define do
  factory :gdpr_request, class: 'Spree::GdprRequest' do
    intent { Spree::GdprRequest.intents.values.sample }
    user

    trait :served do
      served_at { Time.now }
    end
  end
end
