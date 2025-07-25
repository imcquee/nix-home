{ pkgs, ... }:
with pkgs;
[
  # Monitoring
  zenith
  cocoapods
  bun
  nodejs_22
  fastlane
  eas-cli

  android-tools
]
