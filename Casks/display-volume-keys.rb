cask "display-volume-keys" do
  version "1.1.1"
  sha256 "0de19e4955c367a19d06a29886158cb009564824951aa957eb62b86eba18321b"

  url "https://github.com/ari92p/display-volume-keys/releases/download/v#{version}/DisplayVolumeKeys-#{version}.zip"
  name "DisplayVolumeKeys"
  desc "Control external display speaker volume with the keyboard volume keys"
  homepage "https://github.com/ari92p/display-volume-keys"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on formula: "m1ddc"
  depends_on macos: :ventura

  app "DisplayVolumeKeys.app"

  # The app is signed with the project's own certificate but not notarized,
  # so Gatekeeper would block it until the user clicks "Open Anyway".
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/DisplayVolumeKeys.app"],
        writable_paths: "DisplayVolumeKeys.app",
        writable_base:  :appdir
  end

  uninstall quit: "io.github.ari92p.DisplayVolumeKeys"

  zap trash: "~/Library/Preferences/io.github.ari92p.DisplayVolumeKeys.plist"
end
