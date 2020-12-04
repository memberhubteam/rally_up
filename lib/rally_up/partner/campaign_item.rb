# frozen_string_literal: true

module RallyUp
  module Partner
    class CampaignItem
      attr_accessor :id, :campaign_id, :campaign_type, :title, :type,
                    :terminology_singular, :terminology_plural, :thumbnail_url,
                    :price, :description, :bundle_quantity,
                    :total_quantity_available, :total_sold,
                    :available_start_date, :availableend_date, :availability,
                    :category, :associated_prize_id, :associated_prize_title

      def initialize(json)
        @id = json[:Id]
        @campaign_id = json[:CampaignId]
        @campaign_type = json[:CampaignType]
        @title = json[:Title]
        @type = json[:Type]
        @terminology_singular = json[:TerminologySingular]
        @terminology_plural = json[:TerminologyPlural]
        @thumbnail_url = json[:ThumbnailUrl]
        @price = json[:Price]
        @description = json[:Description]
        @bundle_quantity = json[:BundleQuantity]
        @total_quantity_available = json[:TotalQuantityAvailable]
        @total_sold = json[:TotalSold]
        @available_start_date = json[:AvailableStartDate]
        @availableend_date = json[:AvailableEndDate]
        @availability = json[:Availability]
        @category = json[:Category]
        @associated_prize_id = json[:AssociatedPrizeId]
        @associated_prize_title = json[:AssociatedPrizeTitle]
      end

      class << self
        def list(campaign_id)
          json = RallyUp::Partner.json(:get, '/v1/partnerapi/campaignitems', params: {
                                         campaignID: campaign_id
                                       })
          RallyUp::ListObject.new(json, self)
        end
      end
    end
  end
end
