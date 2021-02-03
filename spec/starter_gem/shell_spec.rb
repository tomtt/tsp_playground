RSpec.describe StarterGem::Shell do
  let(:err_double) { double("err") }
  let(:out_double) { double("out", puts: nil) }

  it "exits without replacing if no argument is passed" do
    argv = []
    expect(err_double).to receive(:puts).with ::StarterGem::Shell::BANNER
    expect(lambda { ::StarterGem::Shell.start(argv, out: out_double, err: err_double) }).to raise_error SystemExit
  end

  # This is an example of how you could hand over to a class
  it "does something if there is one argument" do
    argv = ["cookies"]
    do_something_double = double(::StarterGem::DoSomething, show: nil)
    expect(::StarterGem::DoSomething)
      .to receive(:new)
      .with({color: "cookies", show_version: false}, out: out_double, err: err_double)
      .and_return(do_something_double)
    ::StarterGem::Shell.start(argv, out: out_double, err: err_double)
  end

  it "exits without replacing if more than one argument is passed" do
    argv = ["one", "two"]
    expect(err_double).to receive(:puts).with ::StarterGem::Shell::BANNER
    expect(lambda { ::StarterGem::Shell.start(argv, out: out_double, err: err_double) }).to raise_error SystemExit
  end

  it "sets show_version to true if -v option is passed" do
    argv = ["chocolate", "-v"]
    expect(out_double).to receive(:puts).with("version: #{StarterGem::VERSION}")
    ::StarterGem::Shell.start(argv, out: out_double, err: err_double)
  end
end
