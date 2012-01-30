require 'codebar'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

def image_path(filename)
  File.join(File.dirname(__FILE__), 'images', filename)
end

def bits_from_image(filename)
  path = image_path(filename)

  processor = Codebar::Image::Processor.new
  img = processor.process(path)
  extractor = Codebar::Image::Extractor.new(img)

  extractor.extract
end
