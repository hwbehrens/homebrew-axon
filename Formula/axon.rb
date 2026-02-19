class Axon < Formula
  desc "Agent eXchange Over Network, LLM-first local messaging daemon"
  homepage "https://github.com/hwbehrens/axon"
  url "https://github.com/hwbehrens/axon/archive/refs/tags/v0.7.2.tar.gz"
  sha256 "5a4d0d01aaab51137b4be02da4e282fb03c0f7f61616b51abae9e26b7587f106"
  license "MIT"
  head "https://github.com/hwbehrens/axon.git", branch: "main"

  bottle do
    root_url "https://github.com/hwbehrens/homebrew-axon/releases/download/axon-0.7.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4cc2cec798173682c1d7f798fdb489e342b38b2da56a6f0617caf77398859406"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "11a1df98b45bee5314d0cc8c96a640fdcf57baad24050169c28d2e414e4002c8"
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
