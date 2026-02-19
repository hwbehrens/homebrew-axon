class Axon < Formula
  desc "Agent eXchange Over Network, LLM-first local messaging daemon"
  homepage "https://github.com/hwbehrens/axon"
  url "https://github.com/hwbehrens/axon/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "99a2915e6e9155fa9b6a2339098e496d70cb27b165a2ce343e97b7808d0b21dd"
  license "MIT"
  head "https://github.com/hwbehrens/axon.git", branch: "main"

  bottle do
    root_url "https://github.com/hwbehrens/homebrew-axon/releases/download/axon-0.7.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1edaca2d60ad0dd170c31760dcfb6ff4cf1358958bdace8a617fca28e2025ac2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d20c1d14958a991181dd2efa625365edd1ee697ad8fd8708f58ba7fe1e40c1c6"
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
