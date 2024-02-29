module TspPlayground
  module Strategy
    # A strategy that swaps points and picks the best one
    class RandomLinksWithNearestNeighbour
      attr_reader :geography

      def initialize(geography:)
        @geography = geography
        @current_order = nil
        @number_of_candidates = 1
      end

      def next_route
        linked_locations = pick_two_different_locations
        # @seed = {"922"=>"543", "547"=>"929", "186"=>"354"} # 13276.422
        # @seed = {"922"=>"543", "547"=>"929", "186"=>"354", "266"=>"282"} # 13233.739
        # @seed = {"922"=>"543", "547"=>"929", "186"=>"354", "266"=>"282", "236"=>"499"} # 13175.686
        # @seed = {"922"=>"543", "547"=>"929", "186"=>"354", "266"=>"282", "236"=>"499", "854"=>"728"} # 13129.337
        # @seed = {"922"=>"543", "547"=>"456", "186"=>"354", "266"=>"282", "236"=>"499", "854"=>"728"} # 13085.978
        @seed = {"922"=>"543", "547"=>"929", "186"=>"354", "266"=>"282", "236"=>"499", "854"=>"728", "735"=>"101"} # 13086.732
        @seed[linked_locations[0]] = linked_locations[1]
        compute_nearest_neighbour_route
      end

      def pick_two_different_locations
        @geography.unordered_route.sample(2)
      end

      def compute_nearest_neighbour_route # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
        @current_location = geography.start_location
        @current_route = [@current_location]
        @locations_to_visit = geography.unordered_route[1..].dup # do not include the start location
        @locations_to_visit -= @seed.values

        until @locations_to_visit.empty?
          next_location = if @seed.key?(@current_location)
                            @seed[@current_location]
                          else
                            nearest_location_to_current_location(locations_to_visit: @locations_to_visit)
                          end

          @current_location = next_location
          @locations_to_visit.delete(next_location)
          @current_route << next_location
        end

        route_from_order(@current_route)
      end

      def nearest_location_to_current_location(locations_to_visit:)
        @locations_to_visit.min_by do |location|
          geography.distance_between_cities(@current_location, location)
        end
      end

      def route_from_order(order)
        TspPlayground::Route.new(
          city_order: order + [geography.start_location],
          geography:
        )
      end

      def state_description
        @seed.inspect
      end
    end
  end
end