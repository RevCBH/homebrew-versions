class Docker171 < Formula
  desc "The Docker framework for containers"
  homepage "https://www.docker.com/"
  url "https://github.com/docker/docker.git",
      :tag => "v1.7.1",
      :revision => "786b29d4db80a6175e72b47a794ee044918ba734"

  #bottle do
    #cellar :any
    #sha256 "f6f3a78dcd9e9154b1285ab1e74b3ba1ba33f7466195b50caadf0b55c8028e22" => :yosemite
    #sha256 "91c81898fc2b781c43e734812da9310bfd9b207892ee07df518395e2df115bb7" => :mavericks
    #sha256 "dccb74261f9f0f70abf82852e3ade21914a6edaaee47f373af46cd7783c6a832" => :mountain_lion
  #end

  option "without-completions", "Disable bash/zsh completions"

  depends_on "go" => :build

  conflicts_with "docker", :because => "Differing version of the same formula"

  def install
    ENV["AUTO_GOPATH"] = "1"
    ENV["DOCKER_CLIENTONLY"] = "1"

    system "hack/make.sh", "dynbinary"
    bin.install "bundles/#{version}/dynbinary/docker-#{version}" => "docker"

    if build.with? "completions"
      bash_completion.install "contrib/completion/bash/docker"
      zsh_completion.install "contrib/completion/zsh/_docker"
    end
  end

  test do
    system "#{bin}/docker", "--version"
  end
end
