<div align="center"><img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nixos-white.png" width="300px"></div>

### 🖥️ New machine setup

Build ISO: `nix build .#nixosConfigurations.iso.config.system.build.isoImage`

Installation guide: <https://nixos.org/manual/nixos/unstable/#sec-installation-manual>

### ❄️ NixOS Config

1. Clone repo

```bash
git clone https://github.com/imcquee/nix-home.git
```

2. Get tailscale [key](https://login.tailscale.com/admin/settings/keys) and replace 'tskey-examplekeyhere' in tailscale.nix
  
3. Rebuild host

```bash
sudo nixos-rebuild switch --flake /home/$USER/nix-home/#dev
```
  
4. On subsequent runs, just run rebuild <hostname> e.g. : `rebuild dev`

### 🏡 Home-Manger setup

1. Install Nix

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
home-manager switch --flake /home/$USER/nix-home#universal
```

5. On subsequent runs, just run rebuild <hostname> e.g. : `rebuild universal`

6. Install tailscale

```bash
curl -fsSL https://tailscale.com/install.sh | sh
```

### 🍎 Darwin setup

1. Install Nix

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. Setup Git (if not already installed)

```bash
nix-shell -p git
```

3. Clone repo

```bash
git clone https://github.com/imcquee/nix-home.git
```

4. Rebuild host

```bash
nix run nix-darwin -- switch --flake .#MBP2018
```

5. On subsequent runs, just run rebuild <hostname> e.g. : `rebuild MBP2018`

### Useful tips

#### Upgrading flake

1. nix flake update

#### Authenticating with GitHub

1. `gh auth login`
2. `gh auth setup-git`

#### Cleanup storage

Delete stale paths: `nix-collect-garbage`

Delete stale paths and generations older than x days: `nix-collect-garbage --delete-older-than 30d`

### TODO

- [x] Make public
- [x] Migrate Neovim
- [x] Fix copy paste in neovim
- [x] Add DE option
- [x] Add Non-Nixos
- [x] Build custom installer
- [x] Migrate Darwin over
- [ ] Migrate to Nix managed Fish
- [ ] Add Github actions integration with cachix
- [ ] Add Stylix config
- [ ] Add WSL setup
- [ ] Build custom bootstrap script for Non-Nixos environments
- [ ] Fix systemd services
