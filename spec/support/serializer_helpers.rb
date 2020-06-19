# frozen_string_literal: true

module SerializerHelpers
  def prepare_for_snapshot(serializer)
    nullify_values(serializer.as_json).to_json
  end

  def nullify_values(object)
    if object.is_a?(Hash)
      object.transform_values(&method(__method__))
    elsif object.is_a?(Array)
      object.map(&method(__method__))
    end
  end
end

RSpec.configure do |config|
  config.include SerializerHelpers
end

RSpec::Matchers.define :match_snapshot do |snapshot_name|
  match do |actual|
    filename = "#{snapshot_name}.snap"
    snap_path = SolidusGdpr::Engine.root.join('spec/snapshots', filename)
    return false unless File.exist?(snap_path)

    actual.to_s == File.read(snap_path).to_s.chomp
  end
end
