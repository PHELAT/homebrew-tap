class Asdf < Formula
  desc "Agent Session & Directory Forker"
  homepage "https://github.com/PHELAT/asdf"
  url "https://github.com/PHELAT/asdf/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "57cba2e47bfb7041abcff94932d205f453fe5a0e3bc4d67a405170ac0f7be417"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/PHELAT/homebrew-tap/releases/download/asdf-1.1.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "62a01dd450a547bde75e4cb0e91ddf78e5b2fe509b614ab17e51e29272cdb63e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d38e72d0bd318b0cc5c73c8f1bfda7722167d3ff20e5a1bf41a7e3141c25dc33"
  end

  depends_on "git"
  uses_from_macos "bash"
  uses_from_macos "curl"

  def install
    libexec.install "asdf"

    (bin/"asdf").write <<~BASH
      #!/usr/bin/env bash
      export ASDF_INSTALL_SOURCE=homebrew
      exec "#{libexec}/asdf" "$@"
    BASH

    chmod 0755, bin/"asdf"

    generate_completions_from_executable(bin/"asdf", "--completion", shells: [:bash, :zsh])
  end

  test do
    assert_match "asdf 1.1.1", shell_output("#{bin}/asdf version")
    assert_match "_asdf_completion", shell_output("#{bin}/asdf --completion bash")
  end
end
