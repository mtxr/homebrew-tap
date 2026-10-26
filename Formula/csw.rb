class Csw < Formula
  desc "Switch between Claude Code and Claude Desktop accounts"
  homepage "https://github.com/mtxr/claude-switch"
  version "1.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.1.0/csw-aarch64-apple-darwin"
      sha256 "194d57f21895320570077e572156370983df9c48790ecda4bec434dfdfcaf395"
    end
    on_intel do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.1.0/csw-x86_64-apple-darwin"
      sha256 "3076ad12aaa8bb7233fdb0fb56545108901c8f831b0a120f3ce2019991972ed4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.1.0/csw-aarch64-unknown-linux-musl"
      sha256 "d7dbe7340b25046abde555181a9b3234f29b0737307f11c777372a4dcd70b93f"
    end
    on_intel do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.1.0/csw-x86_64-unknown-linux-musl"
      sha256 "a3c7969abff63935319df244477a0c185cee1ef11ac1c572dc5d6649edf750c6"
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
