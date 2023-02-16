# frozen_string_literal: true

module RallyUp
  module Partner
    class Organization
      attr_accessor :id, :ein, :name, :common_name, :email, :url,
                    :is_tax_exempt, :address, :organization_logo_url,
                    :organization_website_url, :organization_facebook_url,
                    :organization_twitter_url, :primary_currency, :status

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
        @status = json[:Status]
      end

      class << self
        def approve(id)
          RallyUp::Partner.request(:post, '/v1/partnerapi/approvecustomorg', params: {
                                     OrganizationID: id
                                   })
          new(Id: id)
        end

        def create(attrs = {})
          json = RallyUp::Partner.json(:post, '/v1/partnerapi/addcustomorg', params: {
            :Name => attrs[:name],
            :Country => attrs[:country],
            :Address1 => attrs[:address1],
            :Address2 => attrs[:address2],
            :Address3 => attrs[:address3],
            :State => attrs[:state],
            :City => attrs[:city],
            :PostalCode => attrs[:postal_code],
            '501c' => attrs['501c'],
            :EIN => attrs[:ein]
          }.reject { |_k, v| v.nil? })
          new(json[:Result].to_h)
        end

        def delete(id)
          json = RallyUp::Partner.json(:delete, '/v1/partnerapi/deletecustomorg', params: {
                                         OrganizationID: id
                                       })
          new(json[:Result].to_h)
        end

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

        def set_on_behalf_of(id:, on_behalf_of:)
          RallyUp::Partner.request(:post, '/v1/partnerapi/setonbehalfaccount', params: {
                                     OrganizationId: id,
                                     StripeOnBehalfAccountId: on_behalf_of
                                   })
          new(Id: id)
        end
      end
    end
  end
end
