# frozen_string_literal: true

module RallyUp
  class ListObject
    attr_reader :json, :items, :count, :page_index, :page_size,
                :total_count, :total_pages,
                :has_previous_page, :has_next_page
    def initialize(json_response, klass)
      @json = json_response
      if klass
        @items = json.dig(:Result, :Items).to_a.map do |data|
          klass.new(data)
        end
      end
      @count = json_response.dig(:Result, :Count)
      @page_index = json_response.dig(:Result, :PageIndex)
      @page_size = json_response.dig(:Result, :PageSize)
      @total_count = json_response.dig(:Result, :TotalCount)
      @total_pages = json_response.dig(:Result, :TotalPages)
      @has_previous_page = json_response.dig(:Result, :HasPreviousPage)
      @has_next_page = json_response.dig(:Result, :HasNextPage)
    end
  end
end
