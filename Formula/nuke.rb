class Nuke < Formula
  desc "Terminate local processes by port, PID, or process name"
  homepage "https://github.com/charlesonunze/nuke"
  url "https://github.com/charlesonunze/nuke/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "543c67853f96ca7b5ab82f8de5fd486641fc232c20aef11778cfb25d477ac689"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X github.com/charlesonunze/nuke/internal/buildinfo.version=#{version}
      -X github.com/charlesonunze/nuke/internal/buildinfo.commit=a090f8ba5133059b599ac9a3f137fd3b2805641e
      -X github.com/charlesonunze/nuke/internal/buildinfo.date=2026-10-07T01:26:13+01:00
    ]

    system "go", "build", *std_go_args(ldflags: ldflags)
  end

  test do
    assert_match "nuke #{version}", shell_output("#{bin}/nuke version")
    assert_match "no processes found for pid 2147483647",
                 shell_output("#{bin}/nuke pid 2147483647")
  end
end
