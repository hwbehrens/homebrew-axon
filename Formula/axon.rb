class Axon < Formula
  desc "Agent eXchange Over Network, LLM-first local messaging daemon"
  homepage "https://github.com/hwbehrens/axon"
  url "https://github.com/hwbehrens/axon/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "bf1fcec29572874a9a6d35f4678299cc775fbc09fe6d340b8b5b4b2bb5e509b0"
  license "MIT"
  revision 1
  head "https://github.com/hwbehrens/axon.git", branch: "main"

  bottle do
    root_url "https://github.com/hwbehrens/homebrew-axon/releases/download/axon-0.6.0_1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f17c7a84cf4bc811143a4f2252da1c52cd29550ae974c738e1d97a767d9dbd92"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "96f754cceffd65257a0fad0dc25aa7566195558079981a8e3e182e8a23135338"
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
