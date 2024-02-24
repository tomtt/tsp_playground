module TspPlayground
  class StrategyRunner
    def initialize(strategy:, geography:)
      @strategy = strategy
      @geography = geography
      @image_interval = 1000
    end

    def run
      @iteration = 0
      @try_for_next_image = 0
      @shorter_route_found = false

      @shortest_route_distance = BigDecimal("Infinity")
      @shortest_route = nil

      loop do
        next_iteration
      end
    end

    def next_iteration
      @iteration += 1
      route = @strategy.next_route

      if route.distance < @shortest_route_distance
        handle_improvement(route)
      end

      handle_image_creation
    end

    def handle_image_creation
      return unless @iteration >= @try_for_next_image

      write_to_image if @shorter_route_found

      @try_for_next_image += @image_interval
      @shorter_route_found = false
    end

    def handle_improvement(route)
      @shortest_route_distance = route.distance
      @shortest_route = route
      @shorter_route_found = true
      puts "new shortest route: #{@shortest_route_distance} (try #{@iteration})"
      puts route.city_order.join("-")
    end

    def write_to_image
      # TspPlayground::GraphicalDisplay.draw(route:)
      image = TspPlayground::RouteImage.new(route: @shortest_route, iteration: @iteration).draw(1200)
      image.write("images/foo.png")
    end
  end
end