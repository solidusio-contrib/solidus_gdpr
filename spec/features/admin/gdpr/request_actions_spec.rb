# frozen_string_literal: true

require 'spec_helper'

describe 'GDPR request actions', type: :feature, js: true do
  include Warden::Test::Helpers

  let(:admin_user) { create(:admin_user) }

  before { login_as admin_user }

  context 'when a request is already served' do
    before do
      create(:gdpr_request, :served, user: admin_user)

      visit spree.admin_gdpr_requests_path
    end

    it 'does not show the run and delete actions' do
      expect(page).not_to have_selector('.serve-request')
      expect(page).not_to have_selector('.delete-request')
    end
  end

  context 'when a request is not served yet' do
    before do
      create(:gdpr_request, user: admin_user)

      visit spree.admin_gdpr_requests_path
    end

    it 'shows the run and delete actions' do
      expect(page).to have_selector('.serve-request')
      expect(page).to have_selector('.delete-request')
    end
  end

  describe 'GDPR serve' do
    let!(:request) { create(:gdpr_request, intent: 'data_erasure', user: admin_user) }

    before { visit spree.admin_gdpr_requests_path }

    it 'serves the request' do
      expect(request.served_at).to eq(nil)
      find('.serve-request').click
      expect(request.reload.served_at).not_to eq(nil)
    end
  end

  describe 'GDPR delete' do
    before do
      create(:gdpr_request, user: admin_user)

      visit spree.admin_gdpr_requests_path
    end

    it 'serves the request' do
      page.accept_alert 'Are you sure?' do
        find('.delete-request').click
      end

      expect(page).not_to have_selector('[data-hook="admin_requests_index_rows"]')
    end
  end
end
