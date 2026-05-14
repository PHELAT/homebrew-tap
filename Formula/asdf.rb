class Asdf < Formula
  desc "Agent Session & Directory Forker"
  homepage "https://github.com/PHELAT/asdf"
  url "https://github.com/PHELAT/asdf/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "f15124459c7ab492fa4a5b8a9e7c7b91e0c0e2d8cd63091259cfdaf78449aa62"
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
    assert_match "asdf 1.0.0", shell_output("#{bin}/asdf version")
    assert_match "_asdf_completion", shell_output("#{bin}/asdf --completion bash")
  end
end
