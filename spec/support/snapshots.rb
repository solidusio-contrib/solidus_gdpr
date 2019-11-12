# frozen_string_literal: true

require 'rspec/snapshot'

RSpec.configure do |config|
  config.snapshot_dir = 'spec/snapshots'
end
