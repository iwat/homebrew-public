class Qxargs < Formula
  desc "Call xargs quickly"
  homepage "https://github.com/iwat/qxargs"
  url "https://github.com/iwat/qxargs/archive/1.1.0.tar.gz"
  sha256 "d60ca5bfe8f6863782cc4d71e817e1562b5352bd6a660d592f834411967dd318"

  bottle do
    root_url "https://github.com/iwat/qxargs/releases/download/1.1.0"

    cellar :any_skip_relocation
    sha256 "8a0a3ab529174112e25999290916b860bc2a5be0b7df34a14558c3276ecf0ca8" => :sierra
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
