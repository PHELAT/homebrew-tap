class Asdf < Formula
  desc "Agent Session & Directory Forker"
  homepage "https://github.com/PHELAT/asdf"
  url "https://github.com/PHELAT/asdf/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "57cba2e47bfb7041abcff94932d205f453fe5a0e3bc4d67a405170ac0f7be417"
  license "Apache-2.0"

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
