require 'uri'
require 'rest_client'
require 'multi_json'

module Zoop
  class Request
    attr_accessor :path, :method, :parameters, :headers, :query, :full_api_url

    DEFAULT_HEADERS = {
      'Content-Type' => 'application/json',
      'Accept'       => 'application/json',
      'User-Agent'   => "zoop-ruby/#{Zoop::VERSION}"
    }

    def initialize(path, method, options={})
      raise Zoop::RequestError, 'You need to configure a Zoop.marketplace_id (ZOOP_MARKETPLACE_ID), Zoop.user_auth (ZOOP_USER_AUTH), Zoop.password_auth (ZOOP_PASSWORD_AUTH) before performing requests.' unless Zoop.marketplace_id && Zoop.user_auth && Zoop.password_auth

      @path         = path
      @method       = method
      @full_api_url = options[:full_api_url]
      @query        = options[:query]   || Hash.new
      @parameters   = options[:params]  || Hash.new
      @headers      = options[:headers] || Hash.new
    end

    def run
      response = RestClient::Request.execute request_params
      MultiJson.decode response.body
    rescue RestClient::Exception => error
      begin
        parsed_error = MultiJson.decode error.http_body

        if error.is_a? RestClient::ResourceNotFound
          raise Zoop::NotFound.new(parsed_error, request_params, error)
        else
          raise Zoop::ResponseError.new(request_params, parsed_error)
        end
      rescue MultiJson::ParseError
        raise Zoop::ResponseError.new(request_params, error.http_body)
      end
    rescue MultiJson::ParseError
      raise Zoop::ResponseError.new(request_params, response.body)
    rescue SocketError
      raise Zoop::ConnectionError.new $!
    rescue RestClient::ServerBrokeConnection
      raise Zoop::ConnectionError.new $!
    end

    def call
      ZoopObject.convert run
    end

    def self.get(url, options={})
      self.new url, 'GET', options
    end

    def self.post(url, options={})
      self.new url, 'POST', options
    end

    def self.put(url, options={})
      self.new url, 'PUT', options
    end

    def self.delete(url, options={})
      self.new url, 'DELETE', options
    end

    protected

    def request_params
      {
        method:       method,
        user:         Zoop.user_auth,
        password:     Zoop.password_auth,
        url:          full_api_url || full_api_url_with_marketplace,
        payload:      MultiJson.encode(parameters),
        open_timeout: Zoop.open_timeout,
        timeout:      Zoop.timeout,
        headers:      DEFAULT_HEADERS.merge(headers)
      }
    end

    def full_api_url_with_marketplace
      url = Zoop.api_endpoint + "/marketplaces/#{Zoop.marketplace_id}" + path

      if query.present?
        url += '?' + URI.encode_www_form(query)
      end

      url
    end
  end
end
