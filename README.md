# personal-comtrya-recipes

[Comtrya](https://comtrya.dev) manifests for provisioning my Linux workstations. Run all recipes or pick individual ones to set up a fresh system quickly.

## Supported Distributions

| Distribution | Supported |
|--------------|-----------|
| Ubuntu       | ✅        |
| Linux Mint   | ✅        |
| Fedora       | ✅        |

All recipes target **x86_64** with **glibc**.

## Usage

```bash
# Apply everything
comtrya -d ./ apply

# Apply specific recipes
comtrya -d ./ apply -m bottom,starship,docker
```

## Recipes

| Recipe | Description | Distros |
|--------|-------------|---------|
| `bashrcd-standard` | Creates `~/.bashrc.d` directory and wires it into bash startup | Ubuntu, Linux Mint |
| `bottom` | Installs [bottom](https://github.com/ClementTsang/bottom) system monitor from latest GitHub release | Ubuntu, Linux Mint, Fedora |
| `catppuccin-gnome-terminal` | Installs Catppuccin theme for GNOME Terminal | All |
| `discord` | Installs Discord (RPM Fusion on Fedora, `.deb` on Ubuntu/Mint) | Ubuntu, Linux Mint, Fedora |
| `docker` | Installs Docker Engine, enables the daemon, and adds user to `docker` group | Ubuntu, Linux Mint, Fedora |
| `git` | Installs Git (with PPA for latest version on Ubuntu/Mint) | All |
| `jq` | Installs jq | All |
| `just` | Installs [just](https://github.com/casey/just) command runner | Ubuntu, Linux Mint, Fedora |
| `nerd-fonts-hack` | Installs Hack Nerd Font into `~/.local/share/fonts` | All |
| `no-notifications` | Disables GNOME event sounds | All |
| `rpmfusion` | Enables RPM Fusion free and nonfree repositories | Fedora |
| `starship` | Installs [Starship](https://starship.rs) prompt with bashrc integration | Ubuntu, Linux Mint, Fedora |
| `task` | Installs [Task](https://taskfile.dev) runner | Ubuntu, Linux Mint, Fedora |
| `vim` | Installs Vim | All |
| `vscode` | Installs Visual Studio Code | Ubuntu, Linux Mint, Fedora |
| `zen-browser` | Installs [Zen Browser](https://zen-browser.app) to `/opt/zen` | All |
| `zen-browser-extensions` | Installs extensions for Zen Browser via enterprise policies | All |
| `zen-browser-settings` | Configures Zen Browser settings via enterprise policies | All |

## Dependencies Between Recipes

```
starship → bashrcd-standard
discord → rpmfusion (Fedora only)
zen-browser-extensions → zen-browser
```

## LLM / AI Context

- `llms.txt` — Full Comtrya documentation reference for LLM consumption
- `.github/copilot-instructions.md` — Recipe-writing conventions and preferences
