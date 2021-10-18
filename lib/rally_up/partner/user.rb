# frozen_string_literal: true

module RallyUp
  module Partner
    class User
      attr_accessor :id, :first_name, :last_name, :email, :role, :created_date, :added_date,
                    :organization_id

      def initialize(json)
        @id = json[:UserID]
        @organization_id = json[:OrganizationID]
        @first_name = json[:FirstName]
        @last_name = json[:LastName]
        @email = json[:Email]
        @role = json[:Role]
        @created_date = json[:CreatedDate]
        @added_date = json[:AddedDate]
      end

      class << self
        def create(organization_id, email, role = 'Administrator')
          json = RallyUp::Partner.json(:post, '/v1/partnerapi/addorguser', params: {
                                         OrganizationID: organization_id,
                                         Email: email,
                                         Role: role
                                       })
          new(json[:Result].to_h)
        end

        def delete(organization_id, email)
          json = RallyUp::Partner.json(:delete, '/v1/partnerapi/deleteorguser', params: {
                                         OrganizationID: organization_id,
                                         Email: email
                                       })
          new(json[:Result].to_h)
        end

        def list(organization_id)
          json = RallyUp::Partner.json(:get, "/v1/partnerapi/listorgusers?OrganizationID=#{organization_id}")
          RallyUp::ListObject.new(json, self)
        end
      end
    end
  end
end
