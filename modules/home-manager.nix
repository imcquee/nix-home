{
  userName,
  userEmail,
  fullName,
  withGUI,
  homeDir,
  ...
}:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${userName} = import ./home.nix;
  home-manager.extraSpecialArgs = {
    inherit
      userName
      userEmail
      fullName
      withGUI
      homeDir
      ;
  };
}
