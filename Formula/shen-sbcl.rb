class ShenSbcl < Formula
  desc "Shen for Steel Bank Common Lisp"
  homepage "https://github.com/Shen-Language/shen-cl"
  url "https://github.com/Shen-Language/shen-cl/archive/v2.3.0.tar.gz"
  sha256 "feca83a3a72b8a0f81fbaa15f22c65a927140f83a1e86179aabd2352c10a334e"

  depends_on "sbcl" => :build

  resource "shen-kernel" do
    url "https://github.com/Shen-Language/shen-sources/releases/download/shen-21.0/ShenOSKernel-21.0.tar.gz"
    sha256 "7034fedf3513f8080c2a871e2d99689012fe72b59452e5dd87c80720b47409d4"
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
