Encoding.default_external = "UTF-8"

module TspPlayground
  class DoSomething
    def initialize(options, out: stdout, err: stderr)
      @options = options
      @out = out
      @err = err
    end

    def run # rubocop:disable Metrics/MethodLength
      geography = geography_from_file
      shortest_route_distance = BigDecimal("Infinity")
      strategy = TspPlayground::Strategy::Random.new(geography:)

      try_count = 0

      TspPlayground::GraphicalDisplay.with_gnuplot do |gnuplot|
        loop do
          try_count += 1
          route = strategy.next_route

          next unless route.distance < shortest_route_distance

          shortest_route_distance = route.distance
          puts "new shortest route: #{shortest_route_distance} (try #{try_count})"
          puts route.city_order.join("-")

          # TspPlayground::GraphicalDisplay.draw(route:)
          write_to_image(route:)
        end
      end
    end

    def geography_from_file
      parser = TspPlayground::TspDataParser.new(@options[:filename])
      cities = parser.parse
      distance_calculator = TspPlayground::DistanceCalculator.new
      TspPlayground::Geography.new(cities:, distance_calculator:, label: @options[:filename])
    end

    def write_to_image(route:)
      image = TspPlayground::RouteImage.new(route).draw(1200)
      image.write("images/foo.png")
    end
  end
end
