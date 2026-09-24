class Dexo < Formula
  desc "A local-first database workbench for PostgreSQL and MySQL in the terminal"
  homepage "https://github.com/kingdaswinx/Dexo"
  version "1.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.4.0/dexo-aarch64-apple-darwin.tar.gz"
      sha256 "5ed036acd874ecd34e78dd3e3197402f05149e3f1cc1e381e309ff393a780aa7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.4.0/dexo-x86_64-apple-darwin.tar.gz"
      sha256 "d37c26b0a0ac2ada2d80637db330d5c210da6cc1132987a9683439e9e7bbae4d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.4.0/dexo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8a1b058775cce26652241a47f06b5e07ceb7fee87c21e81c21154a31c2ed29f9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.4.0/dexo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "74e3241f384fc8b89db2e712c2e18ea6be43cb48c83ad717808085dd1179dc11"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "dexo"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dexo"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dexo"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dexo"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
