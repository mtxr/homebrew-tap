class Csw < Formula
  desc "Switch between Claude Code and Claude Desktop accounts"
  homepage "https://github.com/mtxr/claude-switch"
  version "1.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.2.0/csw-aarch64-apple-darwin"
      sha256 "cc4cc922768d0616b3dbe87307dd070e03c232f5eeb1869a423604e51f0e510b"
    end
    on_intel do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.2.0/csw-x86_64-apple-darwin"
      sha256 "60983f0f3caf44b131c408790eedc3e5ef735e77f2dc736f3327a663a95e550d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.2.0/csw-aarch64-unknown-linux-musl"
      sha256 "e424161aa40a636c5f97959f11710af5074f87efc5a844ffd5251d83eed4bc76"
    end
    on_intel do
      url "https://github.com/mtxr/claude-switch/releases/download/v1.2.0/csw-x86_64-unknown-linux-musl"
      sha256 "ce8766e745d28904234bf901baf9f934517f7280b798d4fb9f0e1187009270b5"
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
