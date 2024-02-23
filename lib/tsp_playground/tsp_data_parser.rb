module TspPlayground
  class TspDataParser
    attr_reader :filename, :cities, :metadata

    def initialize(filename)
      @filename = filename
      @cities = {}
      @metadata = {}
    end

    def parse # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
      File.open(@filename, 'r') do |file|
        file.each_line do |line|
          data = line.strip.split
          if data.length == 3 && number?(data[0])
            @cities[data[0]] = [data[1].to_f, data[2].to_f]
          else
            key, value = line.strip.split(':')
            @metadata[key.strip] = value.strip if key && value
          end
        end
      end
      @cities
    end

    private

    def number?(string)
      Float(string)
    rescue StandardError
      false
    end
  end
end
