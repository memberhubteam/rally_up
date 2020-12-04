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

      class << self
        def retrieve(set: true)
          json = RallyUp::Partner.json(:get, '/v1/partnertoken', params: {
                                         grant_type: 'password',
                                         username: RallyUp::Partner.login,
                                         password: RallyUp::Partner.secret
                                       })
          token = new(json)
          RallyUp::Partner.token = token.access_token if set
          token
        end
      end
    end
  end
end
