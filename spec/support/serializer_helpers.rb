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
