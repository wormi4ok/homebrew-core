class Freetype < Formula
  desc "Software library to render fonts"
  homepage "https://www.freetype.org/"
  url "https://downloads.sourceforge.net/project/freetype/freetype2/2.10.3/freetype-2.10.3.tar.xz"
  mirror "https://download.savannah.gnu.org/releases/freetype/freetype-2.10.3.tar.xz"
  sha256 "c22244bc766b2d8152f22db7370965431dcb1e408260428208c24984f78e6659"
  license "FTL"

  livecheck do
    url :stable
    regex(/url=.*?freetype[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    cellar :any
    sha256 "16500bbd77b8bbeb9a4ad432c795df313c8ac108f31a28119b794000d2ba05f2" => :catalina
    sha256 "145f95e473addb0b3960a3d2b09ec7437bb6fc2e4083fc1161138c0be1a6921b" => :mojave
    sha256 "c1bca74eb0c7dea15bf7e1cc317560d002483acca010b60986c1eac92abbffbc" => :high_sierra
  end

  depends_on "libpng"

  uses_from_macos "bzip2"
  uses_from_macos "zlib"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--enable-freetype-config",
                          "--without-harfbuzz"
    system "make"
    system "make", "install"

    inreplace [bin/"freetype-config", lib/"pkgconfig/freetype2.pc"],
      prefix, opt_prefix
  end

  test do
    system bin/"freetype-config", "--cflags", "--libs", "--ftversion",
                                  "--exec-prefix", "--prefix"
  end
end
