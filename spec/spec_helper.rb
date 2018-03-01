require 'bundler/setup'
require 'rspec'
require 'factory_bot'
require 'cpf_faker'
require 'zoop'
require 'pry'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.include FactoryBot::Syntax::Methods
  config.include ZoopHelper

  FactoryBot.find_definitions

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
