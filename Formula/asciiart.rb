class Asciiart < Formula
  desc "ASCII Art"
  homepage "https://github.com/iwat/asciiart"
  url "https://github.com/iwat/asciiart/archive/1.0.1.tar.gz"
  sha256 "13919e1f790e429d769ca468e5e4fe7f92baecbe598013f2baefd51c48e4b972"

  bottle do
    root_url "https://github.com/iwat/asciiart/releases/download/1.0.1"

    cellar :any_skip_relocation
    sha256 "ba64b88043d59924e763eceb3fe7b66783b8047833ae89c1138f1abfec8f4941" => :sierra
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
