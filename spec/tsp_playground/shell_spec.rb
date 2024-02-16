RSpec.describe TspPlayground::Shell do
  let(:err_double) { double("err") }
  let(:out_double) { double("out", puts: nil) }

  it "exits without replacing if no argument is passed" do
    argv = []
    expect(err_double).to receive(:puts).with ::TspPlayground::Shell::BANNER
    expect(-> { ::TspPlayground::Shell.run(argv, out: out_double, err: err_double) }).to raise_error SystemExit
  end

  it "does something if there is one argument" do
    argv = ["cookies"]
    ::TspPlayground::Shell.run(argv, out: out_double, err: err_double) do |options|
      expect(options).to eq({color: "cookies"})
    end
  end

  it "exits without replacing if more than one argument is passed" do
    argv = %w[one two]
    expect(err_double).to receive(:puts).with ::TspPlayground::Shell::BANNER
    expect(-> { ::TspPlayground::Shell.run(argv, out: out_double, err: err_double) }).to raise_error SystemExit
  end

  it "sets show_version to true if -v option is passed" do
    argv = ["chocolate", "-v"]
    expect(out_double).to receive(:puts).with("version: #{TspPlayground::VERSION}")
    ::TspPlayground::Shell.run(argv, out: out_double, err: err_double) do |options|
      expect(options).to eq({color: "chocolate"})
    end
  end

  it "raises an error if no block is given" do
    argv = ['blue']
    expect(-> { ::TspPlayground::Shell.run(argv, out: out_double, err: err_double) }).to raise_error LocalJumpError
  end
end
