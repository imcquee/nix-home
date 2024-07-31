### Nixos Config

New machine setup

1. Clone repo
2. replace ./hardware-configuration.nix with the one generated by `nixos-generate-config`
3. ```sudo nixos-rebuild switch --flake /home/imcquee/nix-home/#<hostname>```
4. On subsequent runs, just run `rebuild <hostname>`
5. Get tailscale key from <https://login.tailscale.com/admin/settings/keys> and replace 'tskey-examplekeyhere' in tailscale.nix
6. ```gh auth login```
7. Setup copilot in neovim

Upgrade

1. nix flake update

### Non-Nixos setup

1. Install Nix

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Or using Determinate Systems installer

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. Setup Home-Manger and Git (if not already installed)

```bash
nix-shell -p git home-manager
```

3. Clone repo

```bash
git clone https://github.com/imcquee/nix-home.git
```

4. Setup Home-Manager

```bash
home-manager switch --flake /home/imcquee/nix-home#home
```

```

### TODO

- [x] Make public
- [x] Migrate Neovim
- [x] Fix copy paste in neovim
- [x] Add DE option
- [x] Add Non-Nixos + WSL setup
- [ ] Fix systemd services
- [ ] Build custom installer
- [ ] Migrate Darwin over
