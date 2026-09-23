class Dexo < Formula
  desc "A local-first database workbench for PostgreSQL and MySQL in the terminal"
  homepage "https://github.com/kingdaswinx/Dexo"
  version "1.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.2.0/dexo-aarch64-apple-darwin.tar.gz"
      sha256 "e8bc2f288ab14e374b265575764ae2ddd624887bbda21b3fd70733f4e14f413c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.2.0/dexo-x86_64-apple-darwin.tar.gz"
      sha256 "a784b1eefbf759f983a2eded23fe1989eecdee1928a5c3439cf5c2af6cd7487d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.2.0/dexo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6dc7ee825c8391e2f9e7cb1629867ef9e62872ba9f5f5d5b004d7fb0cad7de21"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.2.0/dexo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "942cf4a3cc18630b6e4610c349dddeffe85e8a18bb624ee1dfd88d02b54de9ee"
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
