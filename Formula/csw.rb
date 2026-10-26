class Csw < Formula
  desc "Switch between Claude Code and Claude Desktop accounts"
  homepage "https://github.com/mtxr/claude-switch"
  version "1.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.0.1/csw-aarch64-apple-darwin"
      sha256 "5222144dd75f94d5c666164fb62369b50b1aabfeb6966870f4e422415215956e"
    end
    on_intel do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.0.1/csw-x86_64-apple-darwin"
      sha256 "9371f12af674c9d7a08ee8e5a7137e6b05caee793c505ddcfa6f2ea0e1ff754c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.0.1/csw-aarch64-unknown-linux-musl"
      sha256 "5ea824e1bb464aeced6ac4f5e28dd0fef067b71b6fb653751f806f9c506186e0"
    end
    on_intel do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.0.1/csw-x86_64-unknown-linux-musl"
      sha256 "04f6102efcd943943761b3818e441b86808c819e72cd03e74a5ec8e04cdfa3d0"
    end
  end

  def install
    bin.install Dir["csw-*"].first => "csw"
    bin.install_symlink "csw" => "claude-switch"
    (bash_completion/"csw").write Utils.safe_popen_read(bin/"csw", "completion", "bash")
    (zsh_completion/"_csw").write Utils.safe_popen_read(bin/"csw", "completion", "zsh")
    (fish_completion/"csw.fish").write Utils.safe_popen_read(bin/"csw", "completion", "fish")
    (man1/"csw.1").write Utils.safe_popen_read(bin/"csw", "man")
  end

  def caveats
    <<~EOS
      To switch profiles per directory, add this to your shell rc:
        eval "$(csw hook zsh)"   # or: eval "$(csw hook bash)"
      The hook also registers shell completions.

      An interactive picker is built in. Install sk or fzf for fuzzy search:
        brew install sk
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/csw --version")
  end
end
