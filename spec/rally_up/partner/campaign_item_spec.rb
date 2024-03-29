# frozen_string_literal: true

RSpec.describe RallyUp::Partner::CampaignItem do
  let(:campaignitems) { fixture('/partner/campaign_items.json') }

  before do
    RallyUp::Partner.domain = 'my.partnerdomain.com'
    RallyUp::Partner.token = RallyUp::Partner::Token.new(access_token: 'tok3n', '.expires': (Time.now + 3600).iso8601)
  end

  describe '#list' do
    it 'makes HTTP GET request and renders Campaign Items with campaignID' do
      stub_request(:get, 'https://my.partnerdomain.com/v1/partnerapi/campaignitems?campaignID=1')
        .with(
          headers: { 'Host' => 'my.partnerdomain.com', 'Authorization' => 'Bearer tok3n' }
        ).to_return(status: 200, body: campaignitems, headers: {})

      campaignitems = RallyUp::Partner::CampaignItem.list(1)
      expect(campaignitems.items.count).to eq(3)
    end
  end
end
