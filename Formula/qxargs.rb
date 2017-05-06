# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Qxargs < Formula
  desc "Call xargs quickly"
  homepage "https://github.com/iwat/qxargs"
  url "https://github.com/iwat/qxargs/archive/1.0.0.tar.gz"
  sha256 "47029c5c4bfd823f7c303adae56db0ad8e1dcbec66ad2ba25959b59c90d1cdc7"

  bottle do
    root_url "https://github.com/iwat/qxargs/releases/download/1.0.0"

    cellar :any_skip_relocation
    sha256 "40088a1122ab7c86b71d2e18e220ff78aa657e30a3b59c7aa112be04130c1be5" => :sierra
  end

  depends_on "go" => :build

  def install
    contents = Dir["{*,.git,.gitignore}"]
    gopath = buildpath/"gopath"
    (gopath/"src/github.com/iwat/qxargs").install contents

    ENV["GOPATH"] = gopath
    ENV.prepend_create_path "PATH", gopath/"bin"

    cd gopath/"src/github.com/iwat/qxargs" do
      system "go get -v ./..."
      system "go install"
    end

    bin.install gopath/"bin/qxargs"
  end

  test do
    system "#{bin}/qxargs"
  end
end
