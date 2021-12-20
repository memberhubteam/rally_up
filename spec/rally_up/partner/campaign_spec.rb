# frozen_string_literal: true

RSpec.describe RallyUp::Partner::Campaign do
  let(:campaign) { fixture('/partner/campaign.json') }
  let(:campaigns) { fixture('/partner/campaigns.json') }

  before do
    RallyUp::Partner.domain = 'my.partnerdomain.com'
    RallyUp::Partner.token = RallyUp::Partner::Token.new(access_token: 'tok3n', '.expires': (Time.now + 3600).iso8601)
  end

  describe '#list' do
    it 'makes HTTP GET request and renders Campaigns' do
      stub_request(:get, 'https://my.partnerdomain.com/v1/partnerapi/campaigns?organizationID=1')
        .with(
          headers: { 'Host' => 'my.partnerdomain.com', 'Authorization' => 'Bearer tok3n' }
        ).to_return(status: 200, body: campaigns, headers: {})

      campaigns = RallyUp::Partner::Campaign.list(organization_id: 1)
      expect(campaigns.items.count).to eq(5)
    end

    it 'makes HTTP GET request and renders Campaigns with allowed parameters' do
      stub_request(:get, 'https://my.partnerdomain.com/v1/partnerapi/campaigns?organizationID=1&endDate=2020-01-24&startDate=2020-01-01')
        .with(
          headers: { 'Host' => 'my.partnerdomain.com', 'Authorization' => 'Bearer tok3n' }
        ).to_return(status: 200, body: campaigns, headers: {})

      campaigns = RallyUp::Partner::Campaign.list(organization_id: 1, start_date: '2020-01-01', end_date: '2020-01-24')
      expect(campaigns.items.count).to eq(5)
    end
  end

  describe '#retrieve' do
    it 'makes HTTP GET request and renders Campaigns' do
      stub_request(:get, 'https://my.partnerdomain.com/v1/partnerapi/campaigns/123')
        .with(headers: { 'Host' => 'my.partnerdomain.com', 'Authorization' => 'Bearer tok3n' })
        .to_return(status: 200, body: campaign, headers: {})

      campaign = RallyUp::Partner::Campaign.retrieve(123)
      expect(campaign.id).to eq(44_830)
    end
  end
end
