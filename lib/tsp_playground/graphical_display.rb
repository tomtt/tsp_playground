require "gnuplot"

# Shows route plot in gnuplot
#
# To avoid the "qt.qpa.fonts: Populating font family aliases took xx ms." warning, set the following environment variable:
# export GNUTERM="qt font \"Arial,12\""

module TspPlayground
  class GraphicalDisplay
    def self.draw(route:)
      with_gnuplot do |plot|
        plot_route(plot, route.coordinates)
      end
    end

    def self.plot_route(plot, data)
      plot.data << Gnuplot::DataSet.new(data.transpose) do |ds|
        ds.with = "linespoints"
        ds.notitle
      end
    end

    def self.with_gnuplot
      Gnuplot.open do |gp|
        Gnuplot::Plot.new(gp) do |plot|
          plot.title  "Cities"
          plot.xlabel "X"
          plot.ylabel "Y"
          yield plot
        end
      end
    end
  end
end
