class Nuke < Formula
  desc "Terminate local processes by port, PID, or process name"
  homepage "https://github.com/charlesonunze/nuke"
  url "https://github.com/charlesonunze/nuke/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "0b52e8625d74d066c977df087f4495c0e96aacf84863f81d2e5444be66f77780"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X github.com/charlesonunze/nuke/internal/buildinfo.version=#{version}
      -X github.com/charlesonunze/nuke/internal/buildinfo.commit=b9446051ea413c1fcb169538e0b2eb0b84450575
      -X github.com/charlesonunze/nuke/internal/buildinfo.date=2026-10-07T01:58:36+01:00
    ]

    system "go", "build", *std_go_args(ldflags: ldflags)
  end

  test do
    assert_match "nuke #{version}", shell_output("#{bin}/nuke version")
    assert_match "no processes found for pid 2147483647",
                 shell_output("#{bin}/nuke pid 2147483647")
  end
end
