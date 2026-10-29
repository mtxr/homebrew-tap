class Csw < Formula
  desc "Switch between Claude Code and Claude Desktop accounts"
  homepage "https://github.com/mtxr/claude-switch"
  version "1.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.2.1/csw-aarch64-apple-darwin"
      sha256 "bf0d462aa7356ce689d162b039cd04a014102396c0ec418669c2b9ef7d96b643"
    end
    on_intel do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.2.1/csw-x86_64-apple-darwin"
      sha256 "caa549c63adff387e008ddc9910d59b2c28610adaef19dbece86ff4ddf40afac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.2.1/csw-aarch64-unknown-linux-musl"
      sha256 "7bc469e28e905f98be4b6fb8ea5796cbc84d3529a912fd549fc3760bd1cf238a"
    end
    on_intel do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.2.1/csw-x86_64-unknown-linux-musl"
      sha256 "9a493f9403bbcd83cb954615f056456ef13478af529ced0e8f301289c7b00150"
    end
  end

  def install
    bin.install Dir["csw-*"].first => "csw"
    chmod 0755, bin/"csw"
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
