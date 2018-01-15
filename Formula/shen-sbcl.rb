class ShenSbcl < Formula
  desc "Shen for Steel Bank Common Lisp"
  homepage "https://github.com/Shen-Language/shen-cl"
  url "https://github.com/Shen-Language/shen-cl/archive/v2.2.0.tar.gz"
  sha256 "bac94dd2a7918550c9c5c9e8970564d3a5d7beec7e10cc095d4d45c2eda034c3"

  depends_on "sbcl" => :build

  resource "shen-kernel" do
    url "https://github.com/Shen-Language/shen-sources/releases/download/shen-20.1/ShenOSKernel-20.1.tar.gz"
    sha256 "c0a36109ab6d3ecbf86d09cd31e6e1e93ec010cea516c982a878c5808692f213"
  end

  def install
    ENV.deparallelize
    resource("shen-kernel").stage buildpath/"kernel"
    system "make", "build-sbcl"
    mv "bin/sbcl/shen", "bin/sbcl/shen-sbcl"
    bin.install "bin/sbcl/shen-sbcl"
  end

  test do
    assert_equal "3", shell_output("#{bin}/shen-sbcl -e '(+ 1 2)'")
  end
end
