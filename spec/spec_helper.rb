require 'codebar'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

def image(filename)
  path = File.join(image_folder, filename)
  File.open(path) do |f|
    yield f
  end
end

def image_folder
  File.join(File.dirname(__FILE__), 'images',)
end
