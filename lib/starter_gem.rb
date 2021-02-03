# frozen_string_literal: true

Encoding.default_external = "UTF-8"

require "starter_gem/version"

module StarterGem
  def self.root
    Pathname.new(File.absolute_path(File.join(File.dirname(__FILE__), "..")))
  end

  autoload :DoSomething, "starter_gem/do_something"
  autoload :Shell, "starter_gem/shell"
end
