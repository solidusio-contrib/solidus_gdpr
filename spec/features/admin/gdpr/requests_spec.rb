# frozen_string_literal: true

require 'spec_helper'

describe 'GDPR requests', type: :feature, js: true do
  include Warden::Test::Helpers

  let(:admin_user) { create(:admin_user) }

  before { login_as admin_user }

  context 'when there aren\'t any requests' do
    before { visit spree.admin_gdpr_requests_path }

    it 'shows empty message' do
      expect(page).to have_selector('.no-objects-found')
    end
  end

  context 'when there are requests' do
    context 'when there are fewer than 25 requests' do
      before do
        create(:gdpr_request, :served, intent: 'data_export')
        create(:gdpr_request, intent: 'data_erasure')
        create(:gdpr_request, intent: 'data_restriction')

        visit spree.admin_gdpr_requests_path
      end

      it 'does not show pagination' do
        expect(page).not_to have_selector('.pagination')
      end

      it 'shows the list of requests ordered by served_at and completed_at desc' do
        expect(page).to have_selector('[data-hook="admin_requests_index_rows"]', count: 3)

        within all('[data-hook="admin_requests_index_rows"]').first do
          expect(page).to have_text('Data Restriction')
        end

        within all('[data-hook="admin_requests_index_rows"]')[1] do
          expect(page).to have_text('Data Erasure')
        end

        within all('[data-hook="admin_requests_index_rows"]').last do
          expect(page).to have_text('Data Export')
        end
      end
    end

    context 'when there are more than 25 requests' do
      before do
        create_list(:gdpr_request, 30)

        visit spree.admin_gdpr_requests_path
      end

      it 'shows pagination' do
        expect(page).to have_selector('.pagination', count: 2)
      end
    end
  end
end
