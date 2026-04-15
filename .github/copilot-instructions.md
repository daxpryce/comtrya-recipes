# Copilot Instructions for personal-comtrya-recipes

This repository contains Comtrya manifests (recipes) for provisioning Linux systems.

**Important:** The full Comtrya documentation is available in `llms.txt` at the repo root. Always consult `llms.txt` first for Comtrya usage, action syntax, and context variables — do not fetch from external URLs.

## Repository Structure

Each recipe is a directory with a `main.yaml` entrypoint and an optional `files/` subdirectory for assets (scripts, config files, etc.):

```
recipe-name/
  main.yaml
  files/
    some-script.sh
    some-config.conf
```

## Target Systems

Recipes in this repo target **x86_64 Linux** systems running:
- **Ubuntu**
- **Linux Mint**
- **Fedora**

All three use **glibc** (not musl). When downloading architecture-specific binaries or packages, use the glibc/gnu variant.

## Conventions

### Detecting the OS / Distribution

**Do not** detect the distribution from within shell scripts (e.g. sourcing `/etc/os-release`). Instead, rely on Comtrya's built-in context variables:

- Use `where` clauses: `where: 'os.distribution == "Ubuntu" || os.distribution == "Linux Mint"'`
- Use template variables: `{{ os.distribution }}`, `{{ os.name }}`, `{{ os.version }}`
- Pass distribution info to scripts as CLI arguments from the manifest, e.g.:
  ```yaml
  args:
    - files/script.sh
    - "{{ os.distribution }}"
  ```

See the Contexts section in `llms.txt` for all available variables.

### Known `os.distribution` Values

Comtrya uses the `os_info` Rust crate, whose `Display` impl determines the exact string values.
The distributions this repo targets use these exact values:

| System     | `os.distribution` value |
|------------|-------------------------|
| Ubuntu     | `"Ubuntu"`              |
| Linux Mint | `"Linux Mint"`          |
| Fedora     | `"Fedora"`              |
| Windows    | `"Windows"`             |

Source: https://docs.rs/os_info/latest/src/os_info/os_type.rs.html (the `Display` trait implementation)

### Downloading Files

- **Prefer `file.download`** over `curl` in `command.run` when downloading a single file from a known URL.
- Use `command.run` with a helper script only when the URL must be computed dynamically (e.g. resolving the latest GitHub release tag).

### Installing Packages

- Use `package.install` with the appropriate `provider` (`apt`, `dnf`) whenever possible.
- For distro-specific packages, use `where` clauses to branch:
  ```yaml
  - action: package.install
    where: 'os.distribution == "Ubuntu" || os.distribution == "Linux Mint"'
    name: package-name
    provider: apt

  - action: package.install
    where: 'os.distribution == "Fedora"'
    name: package-name
    provider: dnf
  ```
- Local `.deb`/`.rpm` files can be installed via `package.install` by pointing `name` to the local file path.

### Helper Scripts

- Place helper scripts in the recipe's `files/` directory.
- Make scripts accept configurable arguments (e.g. destination directory) rather than hardcoding paths.
- Prefer passing Comtrya context variables as script arguments over having scripts detect system info themselves.

### File Permissions (chmod)

- Always use **4-octet quoted strings** for `chmod` values: `chmod: "0755"`, not `chmod: 755`.
- Bare integers cause a YAML parse error in Comtrya (`invalid type: integer, expected a string`).

### Style

- Use comments to label sections, especially when the same logical step has distro-specific variants.
- Follow the `── Description (Distro) ──` comment style used in existing recipes.
