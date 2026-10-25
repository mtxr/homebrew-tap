class Csw < Formula
  desc "Switch between Claude Code and Claude Desktop accounts"
  homepage "https://github.com/mtxr/claude-switch"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.0.0/csw-aarch64-apple-darwin"
      sha256 "6801cdea24a619c3cbdf7c72b7ff8db8e7bc6a7dc5403fbf473bb4f2bc5bb85a"
    end
    on_intel do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.0.0/csw-x86_64-apple-darwin"
      sha256 "17a42387d64e2bdad8d5734755907b3f613c6e2f056c6a4113bcb716d1d8168b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.0.0/csw-aarch64-unknown-linux-musl"
      sha256 "2b1e49eaad7f95384208da18b9d02f47c91f544722b5ae3c46b187da93905fb4"
    end
    on_intel do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.0.0/csw-x86_64-unknown-linux-musl"
      sha256 "6d7e9c1e36c5ce524ed0443a59c74fc7ceb2f7d05fd694d247314bf99e49a1f6"
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
