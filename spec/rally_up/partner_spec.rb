# frozen_string_literal: true

RSpec.describe RallyUp::Partner do
  describe '#get' do
    before { RallyUp::Partner.domain = 'my.partnerdomain.com' }

    it 'makes HTTP GET request with appropriate headers' do
      stub_request(:get, 'https://my.partnerdomain.com/v1/hello')
        .with(
          body: 'test=me',
          headers: { 'Host' => 'my.partnerdomain.com' }
        )
        .to_return(status: 200, body: {}.to_json, headers: {})

      request = RallyUp::Partner.get('/v1/hello', params: { test: 'me' })
      expect(request.code).to eq(200)
    end
  end
end
