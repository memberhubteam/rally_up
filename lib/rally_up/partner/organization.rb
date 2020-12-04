# frozen_string_literal: true

module RallyUp
  module Partner
    class Organization
      attr_accessor :id, :ein, :name, :common_name, :email, :url,
                    :is_tax_exempt, :address, :organization_logo_url,
                    :organization_website_url, :organization_facebook_url,
                    :organization_twitter_url, :primary_currency

      def initialize(json)
        @id = json[:Id]
        @ein = json[:Ein]
        @name = json[:Name]
        @common_name = json[:CommonName]
        @email = json[:Email]
        @url = json[:Url]
        @is_tax_exempt = json[:IsTaxExempt]
        @address = json[:Address]
        @organization_logo_url = json[:OrganizationLogoUrl]
        @organization_website_url = json[:OrganizationWebsiteUrl]
        @organization_facebook_url = json[:OrganizationFacebookUrl]
        @organization_twitter_url = json[:OrganizationTwitterUrl]
        @primary_currency = json[:PrimaryCurrency]
      end

      class << self
        def list(start_date: nil, end_date: nil)
          json = RallyUp::Partner.json(:get, '/v1/partnerapi/organizations', params: {
            endDate: end_date,
            startDate: start_date
          }.reject { |_k, v| v.nil? })
          RallyUp::ListObject.new(json, self)
        end

        def retrieve(id)
          json = RallyUp::Partner.json(:get, "/v1/partnerapi/organizations/#{id}")
          new(json[:Result].to_h)
        end
      end
    end
  end
end
