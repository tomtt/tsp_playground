require_relative "lib/tsp_playground/version"

Gem::Specification.new do |spec|
  spec.name = "tsp_playground"
  spec.version = TspPlayground::VERSION
  spec.authors = ["Tom ten Thij"]
  spec.email = ["code@tomtenthij.nl"]

  spec.summary = "A skeleton to start a gem from"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.3.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) {
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Just an example dependency using in example DoSomething class
  spec.add_dependency("bigdecimal")
  spec.add_dependency("gnuplot")
  spec.add_dependency("gruff")
  spec.add_dependency("matrix")
  spec.add_dependency("zeitwerk")

  spec.metadata['rubygems_mfa_required'] = "false"
end
