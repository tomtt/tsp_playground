module TspPlayground
  module Strategy
    # A strategy that tries random routes
    class Random
      attr_reader :geography

      def initialize(geography:)
        @geography = geography
      end

      def next_route
        TspPlayground::Route.new(city_order: geography.random_ordered_route, geography:)
      end
    end
  end
end