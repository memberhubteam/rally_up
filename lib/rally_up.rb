# frozen_string_literal: true

require 'rally_up/version'
require 'rally_up/list_object'
require 'http'
require 'cgi'

module RallyUp
  class << self
    def included(base)
      base.extend Request
    end
  end

  module Request
    def delete(path, params: {}, headers: {})
      request(:delete, path, params: params, headers: headers)
    end

    def get(path, params: {}, headers: {})
      request(:get, path, params: params, headers: headers)
    end

    def post(path, params: {}, headers: {})
      request(:post, path, params: params, headers: headers)
    end

    def put(path, params: {}, headers: {})
      request(:put, path, params: params, headers: headers)
    end

    def request(method, path, domain: 'go.rallyup.com', params: {}, headers: {})
      request_params = method == :get ? { params: params } : { body: URI.encode_www_form(params) }
      response = HTTP.headers(headers).send(method, "https://#{domain}#{path}", request_params)
      verify!(response)
      response
    end

    def json(method, path, params: {}, headers: {})
      response = request(method, path, params: params, headers: headers)
      JSON.parse(response, symbolize_names: true)
    end

    protected

    def verify!(response)
      return if response.code.to_i == 200

      raise Error, response
    end
  end

  class Error < StandardError
    attr_accessor :code, :body

    def initialize(response)
      @body = response.body
      @code = response.code
    end

    def message
      "#{code} #{body}"
    end
  end
end

require 'rally_up/partner'
