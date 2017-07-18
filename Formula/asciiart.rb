class Asciiart < Formula
  desc "ASCII Art"
  homepage "https://github.com/iwat/asciiart"
  url "https://github.com/iwat/asciiart/archive/1.0.0.tar.gz"
  sha256 "a757b88b1b0ee5327d99f6d922013012baa812466185418b702ed25a703bdd61"

  bottle do
    root_url "https://github.com/iwat/asciiart/releases/download/1.0.0"

    cellar :any_skip_relocation
    sha256 "7a61c925a37a609d728b2e23d08a98b0bf20319cc75347d2831be8ef5ea37915" => :sierra
  end

  depends_on "go" => :build

  def install
    contents = Dir["{*,.git,.gitignore}"]
    gopath = buildpath/"gopath"
    (gopath/"src/github.com/iwat/asciiart").install contents

    ENV["GOPATH"] = gopath
    ENV.prepend_create_path "PATH", gopath/"bin"

    cd gopath/"src/github.com/iwat/asciiart" do
      system "go get -v ./..."
      system "go install"
    end

    bin.install gopath/"bin/asciiart"
  end

  test do
    system "#{bin}/asciiart"
  end
end
