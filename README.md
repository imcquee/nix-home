<p align="center"><img src="https://i.imgur.com/X5zKxvp.png" width=150px></p>

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

    If you are building on a new machine, generate a new hardware-configuration.nix using:

    ```bash
    sudo nixos-generate-config
    ```

    Then replace the config in hosts/dev with the new configuration (from the home dir run):

    ```bash
    cp /etc/nixos/hardware-configuration.nix nix-home/hosts/dev/
    ```

    Build from flake:

    ```bash
    sudo nixos-rebuild switch --flake /home/$USER/nix-home/#dev
    ```
  
4. On subsequent runs, just run rebuild <hostname> e.g. : `rebuild dev`

### 🍎 Darwin setup

1. Install Nix

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

> [!WARNING]  
> If you hit choose the default options in the installer, determinate will take control of your nix install. We don't want this with nix-darwin. So answer 'N' to the first question in the installer

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
nix run nix-darwin/master#darwin-rebuild -- switch --flake nix-home/.#MBP2018
# or
nix run nix-darwin/master#darwin-rebuild -- switch --flake nix-home/.#mini
```

5. On subsequent runs, just run rebuild <hostname> e.g. : `rebuild MBP2018`

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

### Useful tips

#### Upgrading flake

1. nix flake update

#### Authenticating with GitHub

1. `gh auth login`
2. `gh auth setup-git`

### Failed to start Home Manager for <User>

The real error is most likely hidden in the logs (Most likely a config file that you are trying to overwrite)

journalctl -xe --unit home-manager-<user>

#### Cleanup storage

Delete stale paths: `nix-collect-garbage`

Delete stale paths and generations older than x days: `nix-collect-garbage --delete-older-than 30d`

### Using Home Manager on Windows WSL

After setting up tailscale, immediately run
`sudo chattr +i /etc/resolv.conf`
To prevent Windows from overwriting the dns config
`sudo chattr -i /etc/resolv.conf`
Reverses this

### TODO

- [x] Make public
- [x] Migrate Neovim
- [x] Fix copy paste in neovim
- [x] Add DE option
- [x] Add Non-Nixos
- [x] Build custom installer
- [x] Migrate Darwin over
- [x] Migrate to Nix managed Fish
- [ ] [Test oneshot tailscale implementation](https://tailscale.com/kb/1096/nixos-minecraft)
- [ ] Add Github actions integration with cachix
- [ ] Add Stylix config
- [ ] Build custom bootstrap script for Non-Nixos environments
- [ ] Fix systemd services
