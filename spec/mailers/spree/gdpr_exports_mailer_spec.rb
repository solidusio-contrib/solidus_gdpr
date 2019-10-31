# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::GdprExportsMailer do
  describe '.export_email' do
    subject(:email) { described_class.export_email(user.email, export: 'export content') }

    let(:user) { build_stubbed(:user) }

    it 'delivers the export to the user' do
      expect(email.to).to eq([user.email])
    end

    it 'attaches the export to the email' do
      expect(email.attachments.first.body.raw_source).to eq('export content')
    end
  end
end
