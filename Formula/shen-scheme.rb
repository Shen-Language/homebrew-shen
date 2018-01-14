class ShenScheme < Formula
  desc "Shen/Scheme implementation"
  homepage "https://github.com/tizoc/shen-scheme"
  url "https://github.com/tizoc/shen-scheme/releases/download/0.16/shen-scheme-0.16-src.tar.gz"
  sha256 "1b6e2d2f99e066b5aa376d11a3591060c0973b1f3ad17a860d7bd3e4d2f32b80"

  depends_on :x11 => :build

  resource "chezscheme" do
    url "https://github.com/cisco/ChezScheme/archive/v9.5.tar.gz"
    sha256 "a1d9f93bd8a683ea3d8f2f1b4880f85ea40bf9a482ee6b84cb0fe0ab6148a98c"
  end

  def install
    ENV.deparallelize
    resource("chezscheme").stage buildpath/"_build/csv9.5"
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    (testpath/"hello.shen").write <<~EOS
      (output "Hello, World!~%")
    EOS

    expected = <<~EOS
      Hello, World!
    EOS

    assert_equal expected, shell_output("#{bin}/shen-scheme --script hello.shen")
  end
end
