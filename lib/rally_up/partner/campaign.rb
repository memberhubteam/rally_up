# frozen_string_literal: true

module RallyUp
  module Partner
    class Campaign
      attr_accessor :id, :name, :url, :campaign_setup_url, :campaign_status,
                    :start_date_utc, :end_date_utc, :amount_raised,
                    :amount_raised_in_period, :amount_goal, :goal_period,
                    :total_views, :total_supporters, :organization_id,
                    :organization_name, :timezone_name, :utcoffset_minutes,
                    :time_remaining_minutes, :thumbnail_url, :cta_label,
                    :management_pages, :primary_currency, :currency_symbol,
                    :project_id, :fund_code

      def initialize(json)
        @id = json[:Id]
        @name = json[:Name]
        @url = json[:Url]
        @campaign_setup_url = json[:CampaignSetupUrl]
        @campaign_status = json[:CampaignStatus]
        @start_date_utc = json[:StartDateUtc]
        @end_date_utc = json[:EndDateUtc]
        @amount_raised = json[:AmountRaised]
        @amount_raised_in_period = json[:AmountRaisedInPeriod]
        @amount_goal = json[:AmountGoal]
        @goal_period = json[:GoalPeriod]
        @total_views = json[:TotalViews]
        @total_supporters = json[:TotalSupporters]
        @organization_id = json[:OrganizationId]
        @organization_name = json[:OrganizationName]
        @timezone_name = json[:TimezoneName]
        @utcoffset_minutes = json[:UtcOffsetMinutes]
        @time_remaining_minutes = json[:TimeRemainingMinutes]
        @thumbnail_url = json[:ThumbnailUrl]
        @cta_label = json[:CtaLabel]
        @management_pages = json[:ManagementPages]
        @primary_currency = json[:PrimaryCurrency]
        @currency_symbol = json[:CurrencySymbol]
        @project_id = json[:ProjectId]
        @fund_code = json[:FundCode]
      end

      class << self
        def list(
          organization_id:, # required
          start_date: nil, # optional
          end_date: nil, # optional
          sort_by: nil, # optional
          campaign_type: nil, # optional
          include_donation_pages: nil, # optional
          status: nil # optional
        )
          json = RallyUp::Partner.json(:get, '/v1/partnerapi/campaigns', params: {
            organizationID: organization_id,
            endDate: end_date,
            startDate: start_date,
            sortBy: sort_by,
            campaignType: campaign_type,
            includeDonationPages: include_donation_pages,
            status: status
          }.reject { |_k, v| v.nil? })
          RallyUp::ListObject.new(json, self)
        end

        def retrieve(id)
          json = RallyUp::Partner.json(:get, "/v1/partnerapi/campaigns/#{id}")
          new(json[:Result].to_h)
        end
      end
    end
  end
end
