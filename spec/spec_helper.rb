$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'
require 'rspec/its'
require 'vcr'
require 'webmock'
require 'chronos'

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = false
  c.cassette_library_dir = "spec/fixtures"
  #c.debug_logger = $stdout
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.shared_context "local paths" do
  def project_dir
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |c|
  c.mock_with :rspec
  c.color = true
  c.formatter = :documentation
  c.tty = true
end
