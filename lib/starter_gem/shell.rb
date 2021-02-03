require "optparse"

module StarterGem
  class Shell
    BANNER = <<~"MSG".freeze
      usage: #{$PROGRAM_NAME} color

      Simple demo that prints color in the color if it knows about the color
    MSG

    def self.usage(err: $stderr)
      err.puts BANNER
      exit 1
    end

    def self.start(argv, out: $stdout, err: $stderr)
      options = gather_options(argv)

      out.puts "version: #{StarterGem::VERSION}" if options[:version]

      usage(err: err) unless argv.size == 1

      options[:color] = argv[0]

      DoSomething.new(options, out: out, err: err).show
    end

    def self.gather_options(argv)
      options = {
        show_version: false
      }

      OptionParser.new { |parser|
        parser.banner = BANNER

        parser.on("-v", "--version", "Show version") do |version|
          options[:version] = version
        end
      }.parse! argv

      options
    end
  end
end
