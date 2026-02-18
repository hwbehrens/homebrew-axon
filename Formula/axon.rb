class Axon < Formula
  desc "Agent eXchange Over Network, LLM-first local messaging daemon"
  homepage "https://github.com/hwbehrens/axon"
  url "https://github.com/hwbehrens/axon/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "bf1fcec29572874a9a6d35f4678299cc775fbc09fe6d340b8b5b4b2bb5e509b0"
  license "MIT"
  revision 1
  head "https://github.com/hwbehrens/axon.git", branch: "main"

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
