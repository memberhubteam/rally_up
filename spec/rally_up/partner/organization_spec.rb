# frozen_string_literal: true

RSpec.describe RallyUp::Partner::Organization do
  let(:organization) { fixture('/partner/organization.json') }
  let(:organizations) { fixture('/partner/organizations.json') }

  before do
    RallyUp::Partner.domain = 'my.partnerdomain.com'
    RallyUp::Partner.token = 'tok3n'
  end

  describe '#list' do
    it 'makes HTTP GET request and renders Organizations' do
      stub_request(:get, 'https://my.partnerdomain.com/v1/partnerapi/organizations')
        .with(headers: { 'Host' => 'my.partnerdomain.com', 'Authorization' => 'Bearer tok3n' })
        .to_return(status: 200, body: organizations, headers: {})

      organizations = RallyUp::Partner::Organization.list
      expect(organizations.items.count).to eq(100)
    end

    it 'makes HTTP GET request and renders Organizations - with params' do
      stub_request(:get, 'https://my.partnerdomain.com/v1/partnerapi/organizations?endDate=2020-01-31&startDate=2020-01-01')
        .with(
          headers: { 'Host' => 'my.partnerdomain.com', 'Authorization' => 'Bearer tok3n' }
        )
        .to_return(status: 200, body: organizations, headers: {})

      organizations = RallyUp::Partner::Organization.list(start_date: '2020-01-01', end_date: '2020-01-31')
      expect(organizations.items.count).to eq(100)
    end
  end

  describe '#retrieve' do
    it 'makes HTTP GET request and renders Organizations' do
      stub_request(:get, 'https://my.partnerdomain.com/v1/partnerapi/organizations/123')
        .with(headers: { 'Host' => 'my.partnerdomain.com', 'Authorization' => 'Bearer tok3n' })
        .to_return(status: 200, body: organization, headers: {})

      organization = RallyUp::Partner::Organization.retrieve(123)
      expect(organization.id).to eq(12_345)
    end
  end
end
