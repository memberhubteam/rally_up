# frozen_string_literal: true

module RallyUp
  module Partner
    include RallyUp

    class << self
      attr_accessor :login, :secret, :domain, :token

      def request(method, path, domain: RallyUp::Partner.domain, params: {}, headers: {})
        set_token if RallyUp::Partner.token.nil? || RallyUp::Partner.token.expired?

        super(
          method,
          path,
          domain: domain,
          params: params,
          headers: headers.merge(
            'Authorization' => "Bearer #{RallyUp::Partner.token.access_token}",
            'Content-Type' => 'application/x-www-form-urlencoded'
          )
        )
      end

      def set_token
        RallyUp::Partner::Token.retrieve(set: true)
      end
    end
  end
end

require 'rally_up/partner/token'
require 'rally_up/partner/campaign'
require 'rally_up/partner/campaign_item'
require 'rally_up/partner/organization'
require 'rally_up/partner/user'
