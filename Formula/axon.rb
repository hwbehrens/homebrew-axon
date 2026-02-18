class Axon < Formula
  desc "Agent eXchange Over Network, LLM-first local messaging daemon"
  homepage "https://github.com/hwbehrens/axon"
  url "https://github.com/hwbehrens/axon/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "8e09ec1c2244bc0c9839993769671bf13014688fd0f411eee8c6e3ddba4fbce1"
  license "MIT"
  head "https://github.com/hwbehrens/axon.git", branch: "main"

  bottle do
    root_url "https://github.com/hwbehrens/homebrew-axon/releases/download/axon-0.7.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e8c5b5aa7bd093439690b135bee3401a3a6d9092e2eb0d86251168ba59592473"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "69f2beecb3c696fa5bc22a8a562686e38cdb44edcc7e9ad72cf7be9945d91863"
  end

  depends_on "rust" => :build

  def install
    cd "axon" do
      system "cargo", "install", *std_cargo_args, "--features", "generate-docs"

      gen_dir = buildpath/"generated"
      system bin/"axon", "gen-docs", "--out-dir", gen_dir

      bash_completion.install gen_dir/"completions/axon.bash"
      zsh_completion.install gen_dir/"completions/_axon"
      fish_completion.install gen_dir/"completions/axon.fish"
      man1.install gen_dir/"man/axon.1"
    end
  end

  test do
    assert_match "Agent eXchange Over Network", shell_output("#{bin}/axon --help")
  end
end
