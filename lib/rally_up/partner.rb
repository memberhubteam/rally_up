# frozen_string_literal: true

module RallyUp
  module Partner
    include RallyUp

    class << self
      attr_accessor :login, :secret, :domain, :token

      def request(method, path, domain: RallyUp::Partner.domain, params: {}, headers: {})
        raise 'Missing RallyUp Partner Token' if RallyUp::Partner.nil?

        super(
          method,
          path,
          domain: domain,
          params: params,
          headers: headers.merge('Authorization' => "Bearer #{RallyUp::Partner.token}")
        )
      end
    end
  end
end

require 'rally_up/partner/token'
require 'rally_up/partner/campaign'
require 'rally_up/partner/campaign_item'
require 'rally_up/partner/organization'
require 'rally_up/partner/user'
