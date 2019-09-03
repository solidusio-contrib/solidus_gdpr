# frozen_string_literal: true

require 'spec_helper'

describe 'GDPR create request', type: :feature, js: true do
  include Warden::Test::Helpers

  let(:admin_user) { create(:admin_user) }

  before do
    login_as admin_user

    visit spree.admin_gdpr_requests_path
  end

  context 'when the form is filled with the correct information' do
    it 'creates the request' do
      expect(page).not_to have_selector('[data-hook="admin_requests_index_rows"]')

      click_on 'New GDPR request'

      select2(admin_user.email, from: 'User')
      find('#gdpr_request_intent').find(:xpath, 'option[2]').select_option

      click_on 'Create'
      expect(page).to have_selector('[data-hook="admin_requests_index_rows"]')
    end
  end

  context 'when the form is filled with the wrong information' do
    it 'shows error messages' do
      click_on 'New GDPR request'
      click_on 'Create'

      expect(page).to have_selector('#errorExplanation')
    end
  end
end
