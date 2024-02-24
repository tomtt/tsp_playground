Encoding.default_external = "UTF-8"

module TspPlayground
  class DoSomething
    def initialize(options, out: stdout, err: stderr)
      @options = options
      @out = out
      @err = err
    end

    def run
      geography = geography_from_file
      strategy = TspPlayground::Strategy::BestFromRandomSwaps.new(geography:)
      StrategyRunner.new(strategy:, geography:).run
    end

    def geography_from_file
      parser = TspPlayground::TspDataParser.new(@options[:filename])
      cities = parser.parse
      distance_calculator = TspPlayground::DistanceCalculator.new
      TspPlayground::Geography.new(cities:, distance_calculator:, label: @options[:filename])
    end
  end
end
