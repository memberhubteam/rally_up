# frozen_string_literal: true

RSpec.describe RallyUp::Partner::Token do
  describe '#retrieve' do
    before do
      RallyUp::Partner.domain = 'my.partnerdomain.com'
      RallyUp::Partner.login  = 'l0gin'
      RallyUp::Partner.secret = 's3cr3t'
      RallyUp::Partner.token  = nil
    end

    let(:json) do
      {
        'access_token' => 'j12948fjas',
        'token_type' => 'bearer',
        'expires_in' => 604_799,
        'UserName' => '{API Login}',
        '.issued' => 'Thu, 11 Jun 2020 21:22:40 GMT',
        '.expires' => 'Thu, 18 Jun 2020 21:22:40 GMT'
      }
    end

    it 'makes HTTP POST request and renders Token' do
      stub_request(:post, 'https://my.partnerdomain.com/v1/partnertoken')
        .with(
          body: 'grant_type=password&username=l0gin&password=s3cr3t',
          headers: { 'Host' => 'my.partnerdomain.com' }
        )
        .to_return(status: 200, body: json.to_json, headers: {})

      token = RallyUp::Partner::Token.retrieve
      expect(token.access_token).to eq(json['access_token'])
      expect(token.token_type).to eq(json['token_type'])
      expect(token.expires_in).to eq(json['expires_in'])
      expect(token.user_name).to eq(json['UserName'])
      expect(token.issued).to eq(json['.issued'])
      expect(token.expires).to eq(json['.expires'])
      expect(RallyUp::Partner.token).to eq(json['access_token'])
    end

    it 'will not set token' do
      stub_request(:post, 'https://my.partnerdomain.com/v1/partnertoken')
        .with(
          body: 'grant_type=password&username=l0gin&password=s3cr3t',
          headers: { 'Host' => 'my.partnerdomain.com' }
        )
        .to_return(status: 200, body: json.to_json, headers: {})

      RallyUp::Partner::Token.retrieve(set: false)
      expect(RallyUp::Partner.token).to eq(nil)
    end
  end
end
