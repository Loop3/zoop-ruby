require 'set'

require_relative 'zoop/version'
require_relative 'zoop/core_ext'
require_relative 'zoop/object'
require_relative 'zoop/model'
require_relative 'zoop/nested_model'
require_relative 'zoop/errors'
require_relative 'zoop/request'
require_relative 'zoop/payment_method_common'
require_relative 'zoop/customer_common'

Dir[File.expand_path('../zoop/resources/*.rb', __FILE__)].map do |path|
  require path
end

module Zoop
  class << self
    attr_accessor :api_endpoint, :open_timeout, :timeout, :marketplace_id, :user_auth, :password_auth
  end

  self.api_endpoint   = 'https://api.zoop.ws/v1'
  self.open_timeout   = 30
  self.timeout        = 90
  self.marketplace_id = ENV['ZOOP_MARKETPLACE_ID']
  self.user_auth      = ENV['ZOOP_USER_AUTH']
  self.password_auth  = ENV['ZOOP_PASSWORD_AUTH']
end
