require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.default_cassette_options = { :erb => true }
  config.allow_http_connections_when_no_cassette = true
end
