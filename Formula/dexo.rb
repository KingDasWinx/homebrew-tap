class Dexo < Formula
  desc "A local-first database workbench for PostgreSQL, MySQL and SQLite in the terminal"
  homepage "https://github.com/kingdaswinx/Dexo"
  version "1.4.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.4.3/dexo-aarch64-apple-darwin.tar.gz"
      sha256 "5e65a95eb7ded9ebbbd2b3d07052ab0350d6d06477ecf5d36b3bc79abba5026d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.4.3/dexo-x86_64-apple-darwin.tar.gz"
      sha256 "f0545a10ac54cfdeb1f5e420f5f9f94b6c8fe697f2bcc1e4d6781dcb7ed5e145"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.4.3/dexo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ae5637fa7307e437123b6370f2842fcab9e36f2ac3975ad8447b92536c0d5c91"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kingdaswinx/Dexo/releases/download/v1.4.3/dexo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "76b460cdf5f69bfee0e9d236c701efa2b9fa16a1f5d6f0311d160674dfeb08df"
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
