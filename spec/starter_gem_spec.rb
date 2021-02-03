RSpec.describe StarterGem do
  it "has a version number" do
    expect(StarterGem::VERSION).not_to be nil
  end

  it "knows its root" do
    expect(StarterGem.root).to eq Pathname.new(Dir.pwd)
  end

  it "contains the files of itself in its root directory" do
    expect(File).to be_exist File.join(StarterGem.root, "lib", "starter_gem", "version.rb")
  end
end
