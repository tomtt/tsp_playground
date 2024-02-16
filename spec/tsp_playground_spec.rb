RSpec.describe TspPlayground do
  it "has a version number" do
    expect(TspPlayground::VERSION).not_to be nil
  end

  it "knows its root" do
    expect(TspPlayground.root).to eq Pathname.new(Dir.pwd)
  end

  it "contains the files of itself in its root directory" do
    expect(File).to be_exist File.join(TspPlayground.root, "lib", "tsp_playground", "version.rb")
  end
end
