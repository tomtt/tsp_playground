module TspPlayground
  class Route
    attr_reader :geography, :city_order

    def initialize(geography:, city_order:)
      @geography = geography
      @city_order = city_order
    end

    def x_values
      @city_order.map { |city| @geography.cities[city][0] - @geography.min_x }
    end

    def y_values
      @city_order.map { |city| @geography.cities[city][1] - @geography.min_y }
    end

    def coordinates
      @city_order.map { |city| @geography.cities[city] }
    end

    def scaled_coordinates
      @city_order.map do |city|
        [
          @geography.cities[city][0] - @geography.min_x,
          @geography.cities[city][1] - @geography.min_y
        ]
      end
    end

    def distance
      return @distance if @distance

      result = 0
      previous_city = @city_order.last
      @city_order.each do |city|
        result += @geography.distance_between_cities(previous_city, city)
        previous_city = city
      end
      @distance = result
    end
  end
end
