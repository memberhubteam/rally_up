# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RallyUp::Partner::User do
  let(:user) { fixture('/partner/user.json') }
  let(:users) { fixture('/partner/users.json') }

  before do
    RallyUp::Partner.domain = 'my.partnerdomain.com'
    RallyUp::Partner.token = RallyUp::Partner::Token.new(access_token: 'tok3n', '.expires': (Time.now + 3600).iso8601)
  end

  describe '#create' do
    let(:org_id) { SecureRandom.hex(3) }
    let(:email) { "#{SecureRandom.hex(3)}@rallyup.com" }
    let(:role) { 'Administrator' }

    it 'makes HTTP POST request and renders Organization User' do
      stub_request(:post, 'https://my.partnerdomain.com/v1/partnerapi/addorguser')
        .with(
          headers: { 'Host' => 'my.partnerdomain.com', 'Authorization' => 'Bearer tok3n' },
          body: "OrganizationID=#{org_id}&Email=#{email.gsub('@', '%40')}&Role=#{role}"
        )
        .to_return(status: 200, body: user, headers: {})

      user = RallyUp::Partner::User.create(org_id, email, role)
      expect(user.id).to eq(42_880)
    end
  end

  describe '#delete' do
    let(:org_id) { SecureRandom.hex(3) }
    let(:email) { "#{SecureRandom.hex(3)}@rallyup.com" }

    it 'makes HTTP DELETE request and renders Organization User' do
      stub_request(:delete, 'https://my.partnerdomain.com/v1/partnerapi/deleteorguser')
        .with(
          headers: { 'Host' => 'my.partnerdomain.com', 'Authorization' => 'Bearer tok3n' },
          body: "OrganizationID=#{org_id}&Email=#{email.gsub('@', '%40')}"
        )
        .to_return(status: 200, body: user, headers: {})

      user = RallyUp::Partner::User.delete(org_id, email)
      expect(user.id).to eq(42_880)
    end
  end

  describe '#list' do
    let(:org_id) { SecureRandom.hex(3) }
    it 'makes HTTP GET request and renders Organization Users' do
      stub_request(:get, "https://my.partnerdomain.com/v1/partnerapi/listorgusers?OrganizationID=#{org_id}")
        .with(headers: { 'Host' => 'my.partnerdomain.com', 'Authorization' => 'Bearer tok3n' })
        .to_return(status: 200, body: users, headers: {})

      users = RallyUp::Partner::User.list(org_id)
      expect(users.items.count).to eq(1)
    end
  end
end
