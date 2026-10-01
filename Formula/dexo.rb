class Dexo < Formula
  desc "A local-first database workbench for PostgreSQL and MySQL in the terminal"
  homepage "https://github.com/kingdaswinx/Dexo"
  version "1.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.4.1/dexo-aarch64-apple-darwin.tar.gz"
      sha256 "c5175d693ddb7380f3683d94762c3fb75c5020e6842d6d75a8667500ac9759d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.4.1/dexo-x86_64-apple-darwin.tar.gz"
      sha256 "b3ba9726ee725bd3e72de9361714d60a639a45e0933591cd781a1dbf5e1eb869"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.4.1/dexo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1e777f0ad5f91ced7b1e668a9f5e081c86037af6afa06b5f8d79419f0179f50e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.4.1/dexo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ca68bae8b127ef45e4fb2f285235c68a99eb7e8ca3d17e3d549e13ac5020b4a2"
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
