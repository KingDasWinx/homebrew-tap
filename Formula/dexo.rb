class Dexo < Formula
  desc "A local-first database workbench for PostgreSQL and MySQL in the terminal"
  homepage "https://github.com/kingdaswinx/Dexo"
  version "1.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.3.0/dexo-aarch64-apple-darwin.tar.gz"
      sha256 "1ac565305271e4840e8d2470adad5428d5e5cc7a03f376683eb801bb36e07c56"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.3.0/dexo-x86_64-apple-darwin.tar.gz"
      sha256 "907c1e1672be70f4b9512d8058585c92979ec5639a24dbec3d654cb5a21726bf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.3.0/dexo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ea43ff7be15b0c2be55fce4600bf46e555855efe9dabf79fa71adc0ccbdfeebe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.3.0/dexo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cdc11e09e7e027c3a24b48417519454af1f76e36cf7d5940306567b1dc172f45"
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
