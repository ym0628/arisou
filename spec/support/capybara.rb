RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium, using: :headless_chrome, screen_size: [360, 780]
  end
  # config.before(:each, js: true, type: :system) do
  # driven_by :selenium_chrome
  # end
end
