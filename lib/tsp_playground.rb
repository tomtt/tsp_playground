# frozen_string_literal: true

Encoding.default_external = "UTF-8"

require "tsp_playground/version"
require "zeitwerk"

module TspPlayground
  class << self
    attr_reader :loader

    def root
      Pathname.new(File.absolute_path(File.join(File.dirname(__FILE__), "..")))
    end

    def setup_loader
      @loader = Zeitwerk::Loader.for_gem
      @loader.enable_reloading
      # @loader.push_dir(ActiveCore.root.join("non-lib/code_dir"))
      @loader.setup
      @loader.eager_load
    end
  end
end

TspPlayground.setup_loader
