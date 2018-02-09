require "zoop/version"

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
