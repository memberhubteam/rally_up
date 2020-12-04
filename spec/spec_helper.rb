# frozen_string_literal: true

require 'bundler/setup'
require 'rally_up'
require 'webmock/rspec'
require 'pry'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  def fixture(path, json: false)
    string = File.read("#{Dir.getwd}/spec/fixtures#{path}")
    return string unless json

    JSON.parse(string, symbolize_names: true)
  end
end
