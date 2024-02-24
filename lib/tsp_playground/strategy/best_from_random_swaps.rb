module TspPlayground
  module Strategy
    # A strategy that swaps points and picks the best one
    class BestFromRandomSwaps
      attr_reader :geography

      def initialize(geography:)
        @geography = geography
        @current_order = nil
        @number_of_candidates = 1
      end

      def generate_candidate_routes
        @candidates = []
        @number_of_candidates.times do
          @candidates << swap_two_points(@current_order)
        end
      end

      def swap_two_points(order)
        new_order = order.dup
        i = rand(order.length)
        j = rand(order.length)
        new_order[i], new_order[j] = new_order[j], new_order[i]
        new_order
      end

      def route_from_order(order)
        TspPlayground::Route.new(
          city_order: [geography.start_location] + order + [geography.start_location],
          geography:
        )
      end

      def best_candidate_route
        (@candidates + [@current_order]).min_by { |candidate| route_from_order(candidate).distance }
      end

      def next_route
        if @current_order
          generate_candidate_routes
          @current_order = best_candidate_route
        else
          @current_order = start_order
        end

        route_from_order(@current_order)
      end

      def start_order
        @start_location = geography.start_location
        geography.unordered_route[1..-1] # do not include the start location
      end
    end
  end
end