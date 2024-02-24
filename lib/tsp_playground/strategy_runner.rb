module TspPlayground
  class StrategyRunner
    def initialize(strategy:, geography:)
      @strategy = strategy
      @geography = geography
      @image_interval = 1000
    end

    def run
      @try_count = 0
      @try_for_next_image = 0

      @shortest_route_distance = BigDecimal("Infinity")

      loop do
        next_iteration
      end
    end

    def next_iteration
      @try_count += 1
      route = @strategy.next_route

      if route.distance < @shortest_route_distance
        handle_improvement(route)
      else
        handle_no_improvement
      end
    end

    def handle_no_improvement; end

    def handle_improvement(route)
      @shortest_route_distance = route.distance
      puts "new shortest route: #{@shortest_route_distance} (try #{@try_count})"
      puts route.city_order.join("-")

      return unless @try_count >= @try_for_next_image

      # TspPlayground::GraphicalDisplay.draw(route:)
      write_to_image(route:)
      @try_for_next_image += @image_interval
    end

    def write_to_image(route:)
      image = TspPlayground::RouteImage.new(route).draw(1200)
      image.write("images/foo.png")
    end
  end
end