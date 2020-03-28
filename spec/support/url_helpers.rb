RSpec.configure do |config|
  config.before :each, type: :helper do
    helper.extend CASino::Engine.routes.url_helpers
  end
end
