### Nixos Config

New machine setup

1. Clone repo
2. replace ./hardware-configuration.nix with the one generated by `nixos-generate-config`
3. ```sudo nixos-rebuild switch --flake /home/imcquee/nix-home/#<hostname>```
4. On subsequent runs, just run `rebuild <hostname>`
5. Login to tailscale and run `tailscale up`
6. ```gh auth login```
7. Setup copilot in neovim

### TODO

- [x] Make public
- [x] Migrate Neovim
- [x] Fix copy paste in neovim
- [ ] Add WSL config
- [ ] Build custom installer
- [ ] Add DE option
- [ ] Migrate Darwin over
