# frozen_string_literal: true

module RallyUp
  module Partner
    class Token
      attr_accessor :access_token, :token_type, :expires_in, :user_name,
                    :issued, :expires

      def initialize(json)
        @access_token = json[:access_token]
        @token_type = json[:token_type]
        @expires_in = json[:expires_in]
        @user_name = json[:UserName]
        @issued = json[:'.issued']
        @expires = json[:'.expires']
      end

      def expired?
        expires.nil? || Time.parse(expires).utc < Time.now.utc
      end

      class << self
        def retrieve(set: true)
          json = JSON.parse(access_token_response, symbolize_names: true)
          token = new(json)
          RallyUp::Partner.token = token if set
          token
        end

        def access_token_response
          params = {
            grant_type: 'password',
            username: RallyUp::Partner.login,
            password: RallyUp::Partner.secret
          }
          HTTP.post("https://#{RallyUp::Partner.domain}/v1/partnertoken", body: URI.encode_www_form(params))
              .body.to_s
        end
      end
    end
  end
end
