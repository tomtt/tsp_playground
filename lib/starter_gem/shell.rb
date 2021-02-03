require "optparse"

module StarterGem
  class Shell
    BANNER = <<~"EOT"
      usage: #{$0} color

      Simple demo that prints color in the color if it knows about the color
    EOT

    def self.usage(err: $stderr)
      err.puts BANNER
      exit 1
    end

    def self.start(argv, out: $stdout, err: $stderr)
      options = {
        show_version: false
      }

      OptionParser.new { |parser|
        parser.banner = BANNER

        parser.on("-v", "--version", "Show version") do |version|
          options[:version] = version
        end
      }.parse! argv

      if options[:version]
        out.puts "version: #{StarterGem::VERSION}"
      end

      unless argv.size == 1
        usage(err: err)
      end

      options[:color] = argv[0]

      DoSomething.new(options, out: out, err: err).show
    end
  end
end
