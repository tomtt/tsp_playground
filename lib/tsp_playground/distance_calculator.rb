module TspPlayground
  class DistanceCalculator
    def initialize
      @distances = {}
    end

    def distance_between(city1, city2)
      key = [city1, city2].sort
      @distances[key] ||= calculate_distance(city1, city2)
    end

    def calculate_distance(city1, city2)
      Math.sqrt(((city2[0] - city1[0])**2) + ((city2[1] - city1[1])**2))
    end
  end
end
