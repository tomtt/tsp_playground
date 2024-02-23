module TspPlayground
  # Geography class to hold the data that is parsed from the TSP file and stays
  # constant throughout the program.

  class Geography
    attr_reader :cities, :distance_calculator, :min_x, :min_y, :label

    def initialize(cities:, distance_calculator:, label:)
      @cities = cities
      @distance_calculator = distance_calculator
      @label = label
      @min_x ||= @cities.values.map { |city| city[0] }.min
      @min_y ||= @cities.values.map { |city| city[1] }.min
    end

    def start_location
      @cities.keys.first
    end

    def distance_between_cities(city1, city2)
      @distance_calculator.distance_between(@cities[city1], @cities[city2])
    end

    def unordered_route
      @cities.keys
    end

    def random_ordered_route
      city_order = unordered_route
      city_order.delete(start_location) # do not shuffle in the start location
      city_order.shuffle!
      [start_location] + city_order + [start_location] # make it a round trip
    end
  end
end
