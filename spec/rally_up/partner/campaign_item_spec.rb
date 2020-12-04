# frozen_string_literal: true

RSpec.describe RallyUp::Partner::CampaignItem do
  let(:campaignitems) { fixture('/partner/campaign_items.json') }

  before do
    RallyUp::Partner.domain = 'my.partnerdomain.com'
    RallyUp::Partner.token = 'tok3n'
  end

  describe '#list' do
    it 'makes HTTP GET request and renders Campaign Items with campaignID' do
      stub_request(:get, 'https://my.partnerdomain.com/v1/partnerapi/campaignitems')
        .with(
          body: 'campaignID=1',
          headers: { 'Host' => 'my.partnerdomain.com', 'Authorization' => 'Bearer tok3n' }
        ).to_return(status: 200, body: campaignitems, headers: {})

      campaignitems = RallyUp::Partner::CampaignItem.list(1)
      expect(campaignitems.items.count).to eq(3)
    end
  end
end
