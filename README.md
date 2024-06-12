### Nixos Config

New machine setup

1. Clone repo
2. replace ./hardware-configuration.nix with the one generated by `nixos-generate-config`
3. sudo nixos-rebuild switch --flake /home/imcquee/nix-home/#nixos
4. On subsequent runs, just run `rebuild`

### TODO

- [x] Make public
- [x] Migrate Neovim
- [ ] Fix copy paste in neovim
- [ ] Add WSL config
- [ ] Add DE option
- [ ] Migrate Darwin over
