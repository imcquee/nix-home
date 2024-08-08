### Nixos Config

New machine setup

1. Clone repo

```bash
git clone https://github.com/imcquee/nix-home.git
```

2. Replace ./hardware-configuration.nix with the one generated by `nixos-generate-config`
  
3. Rebuild host

  ```bash
  sudo nixos-rebuild switch --flake /home/imcquee/nix-home/#<hostname>
  ```
  
4. On subsequent runs, just run:`rebuild <hostname>`

5. Get tailscale [key](https://login.tailscale.com/admin/settings/keys) and replace 'tskey-examplekeyhere' in tailscale.nix

### Upgrade

1. nix flake update

### Non-Nixos setup

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
home-manager switch --flake /home/imcquee/nix-home#universal
```

5. Install tailscale

```bash
curl -fsSL https://tailscale.com/install.sh | sh
```

### TODO

- [x] Make public
- [x] Migrate Neovim
- [x] Fix copy paste in neovim
- [x] Add DE option
- [x] Add Non-Nixos + WSL setup
- [ ] Build custom bootstrap script for Non-Nixos environments
- [ ] Fix systemd services
- [ ] Build custom installer
- [ ] Migrate Darwin over
