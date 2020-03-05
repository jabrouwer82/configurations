class AmmoniteRepl < Formula
  desc "Ammonite is a cleanroom re-implementation of the Scala REPL"
  homepage "https://lihaoyi.github.io/Ammonite/#Ammonite-REPL"
  url "https://github.com/lihaoyi/Ammonite/releases/download/2.0.4/2.12-2.0.4"
  sha256 "044c6b93330c17d6d0cd418cf892a693a8d31475f7560cf2d5ec0f1f62631419"
  revision 1

  bottle :unneeded

  depends_on "openjdk"

  def install
    (libexec/"bin").install Dir["*"].first => "amm"
    chmod 0755, libexec/"bin/amm"
    (bin/"amm").write_env_script libexec/"bin/amm", :JAVA_HOME => "${JAVA_HOME:-#{Formula["openjdk"].opt_prefix}}"
  end

  test do
    output = shell_output("#{bin}/amm -c 'print(\"hello world!\")'")
    assert_equal "hello world!", output.lines.last
  end
end
