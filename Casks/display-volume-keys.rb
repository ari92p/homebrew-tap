cask "display-volume-keys" do
  version "1.0.0"
  sha256 "1610db7cb7cf2b1f068ff5ec1a3e0cd6aa156b02adab736cc6cea304ff98c41d"

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
