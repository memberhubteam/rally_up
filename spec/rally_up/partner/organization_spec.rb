# frozen_string_literal: true

RSpec.describe RallyUp::Partner::Organization do
  let(:organization) { fixture('/partner/organization.json') }
  let(:organizations) { fixture('/partner/organizations.json') }

  before do
    RallyUp::Partner.domain = 'my.partnerdomain.com'
    RallyUp::Partner.token = 'tok3n'
  end

  describe '#approve' do
    let(:id) { SecureRandom.hex(3) }
    it 'makes HTTP POST request and renders Organizations' do
      stub_request(:post, 'https://my.partnerdomain.com/v1/partnerapi/approvecustomorg')
        .with(
          headers: { 'Host' => 'my.partnerdomain.com', 'Authorization' => 'Bearer tok3n' },
          body: "OrganizationID=#{id}"
        )
        .to_return(status: 200, body: '', headers: {})

      organization = RallyUp::Partner::Organization.approve(id)
      expect(organization.id).to eq(id)
    end
  end

  describe '#create' do
    let(:attrs) do
      {
        name: 'name',
        country: 'country',
        address1: 'address1',
        address2: 'address2',
        address3: 'address3',
        state: 'state',
        city: 'city',
        postal_code: 'postalcode',
        '501c' => '501c',
        ein: 'ein'
      }
    end

    let(:expected) do
      {
        Name: 'name',
        Country: 'country',
        Address1: 'address1',
        Address2: 'address2',
        Address3: 'address3',
        State: 'state',
        City: 'city',
        PostalCode: 'postalcode',
        '501c' => '501c',
        EIN: 'ein'
      }
    end

    it 'makes HTTP GET request and renders Organizations' do
      stub_request(:post, 'https://my.partnerdomain.com/v1/partnerapi/addcustomorg')
        .with(
          headers: { 'Host' => 'my.partnerdomain.com', 'Authorization' => 'Bearer tok3n' },
          body: expected.map { |k, v| "#{k}=#{v}" }.join('&')
        )
        .to_return(status: 200, body: organization, headers: {})

      organization = RallyUp::Partner::Organization.create(attrs)
      expect(organization.id).to eq(12_345)
    end
  end

  describe '#delete' do
    let(:id) { SecureRandom.hex(3) }
    it 'makes HTTP DELETE request and renders Organizations' do
      stub_request(:delete, 'https://my.partnerdomain.com/v1/partnerapi/deletecustomorg')
        .with(
          headers: { 'Host' => 'my.partnerdomain.com', 'Authorization' => 'Bearer tok3n' },
          body: "OrganizationID=#{id}"
        )
        .to_return(status: 200, body: organization, headers: {})

      organization = RallyUp::Partner::Organization.delete(id)
      expect(organization.id).to eq(12_345)
    end
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
