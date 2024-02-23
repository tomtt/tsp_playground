require "gruff"

module TspPlayground
  class RouteImage
    def initialize(route)
      @route = route
    end

    def draw(size = 400)
      g = Gruff::Line.new(size)
      g.title = "#{@route.geography.label} (#{@route.distance})"
      g.hide_legend = true
      g.hide_line_markers = true
      g.dataxy('Route', @route.x_values, @route.y_values)
      g
    end
  end
end
