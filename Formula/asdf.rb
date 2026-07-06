class Asdf < Formula
  desc "Agent Session & Directory Forker"
  homepage "https://github.com/PHELAT/asdf"
  url "https://github.com/PHELAT/asdf/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "b8ffe823c9c28b13a7ab9503d0a08a186b66de6ca345df2058173339f8379abb"
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
    assert_match "asdf 1.1.0", shell_output("#{bin}/asdf version")
    assert_match "_asdf_completion", shell_output("#{bin}/asdf --completion bash")
  end
end
