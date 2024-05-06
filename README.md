# meninx

**Please note that this is a re-factor of my current configuration, which is not public! It is a work in progress, and may or may not work at all!**

An overly complicated flake configuration for my Nix(OS) systems. Named for a variant of the word [Meninges](https://en.wikipedia.org/wiki/Meninges), the membranes that surround the human nervous system. Years ago I started naming all my computers after parts of the brain, and when I decided to group all my Nix configurations I needed an umbrella term that was on-theme. "Meninx" fit perfectly, and also almost has the word "Nix" in it. :shrug:

## Disclaimer

This is *my personal configuration* and is not intended to be used as-is outside of my own machines. I make no guarantee that it will work out of the box, and the configuration is subject to change drastically. I'm perfectly happy to field discussion or questions (feel free to open an issue), but I'm hardly an expert on Nix/NixOS and you may have better luck on the NixOS forums. I accept no responsibility for any consequences of attempting to use this configuration for yourself. It is provided as-is for my own convenience and in hopes that it may provide an additional reference for others getting into the Nix space.

## Overview

- System Shell: bash + blesh
- User Shell: zsh + prezto
- Terminal: mostly kitty
- Prompt Theme: heavily configured starship
- Desktop Manager: GDM on laptop, SDDM on desktop
- Desktop Environment: GNOME on laptop, KDE Plasma 6 on desktop
- GUI Editor: VSCode with extensions
- Terminal Editor: helix with some LSP's
- Theme: Catppuccin Mocha on laptop, Breeze Dark on desktop

## To-Do List

- [x] Review for major errors
- [x] Review `TODO` and `FIXME` items
- [ ] Make sure everything got migrated
  - [x] Check against current encephalon config
  - [ ] Check against old cerebrum config
- [x] Add ISO configurations to flake
  - [x] Make sure ISO config actually working
  - [ ] Create encephalon ISO
- [ ] Trim cruft packages
  - [ ] Check emacs-related package list
  - [x] Mark other packages for removal
  - [x] Remove or keep marked packages
- [x] Consolidate package lists
- [x] Create module system
- [x] ~~Fix `pyClock` module (resigned for now)~~
- [ ] Create "minimal" install config
- [x] Re-add non-nix assets/files
- [x] Consider best structure/layout
- [x] Move aliases to standard location
- [ ] Fix package locations (mostly done)
- [x] Fix or remove nix-colors (removed)
- [ ] Create disko config for cerebrum
- [ ] Add inline links/documentation
- [x] Configure git correctly for switch to GitHub
- [x] Figure out networking stuff for Tailscale/NextDNS/Mullvad (done enough for now)
- [ ] Finish testing builds for all systems
- [x] Add AMD GPU configuration
- [ ] Add NixOS-WSL configuration
  - [ ] Main config
  - [ ] ISO config
- [ ] Add more links/wiki/etc.
- [ ] Add back catppuccin themes whenever fixed in GNOME 46
- [ ] Further update README.md

## Future Plans

- Switch to NixOS stable for most packages, and only use unstable for stuff that tends to lag in the stable nixpkgs. Not super hard, but need to go over all my packages by hand to get it set up. Has the benefit of more consistent caching, and theoretically overall stability (although, never had much in the way of system instability on unstable.)
- Add a more nixified way to back up or configure stuff that would be lost or manually reconfigured on a full re-install. Zoxide history, shell history(atuin?), handful of little Firefox tweaks, etc. Also not super difficult, and some of the modules I have planned should solve most of these problems.
- Switch to using individual NUR repositories instead of pulling in the whole thing. Not sure that I really need to do this necessarily, but it just feels a bit better. Example documented in `flake.nix`. Mostly for rycee's NUR repo that has all the Firefox extensions in it, since I don't currently use anything else from the NUR.
- Modularize further for Nix code I'm re-using heavily, and things that don't have modules. Especially for declarative Mullvad settings, as this is currently not possible with the default module/package. Also want to look into adding a firefox-csshacks module that covers options for the whole repo. Hoping to end up contributing some of these to Nix itself.
- Use my own machines as package caches for each other in case I need/want to do a full reinstall of one, or if I get a new machine and have to set it up behind slow internet.
- Set up the old server I have lying around on Nix as well, mostly to be a better package cache instead of my main machines. Also for a bit of cloud storage and some low-demand services I'd like to run going forward.
- Switch from Tailscale to a self-hosted Headscale instance. Should be easily(???) configured with NixOS, given that most of my machines (current and planned) will be running Nix as well. In general, want to self-host as much as possible going forward.
- Better document my entire configuration with actual links out to wherever I got the information, especially in weird cases like my network configuration. Alternatively, switch to an entirely literate-programming config with Org or some other tool.
- Improve overall declarative-ness, especially for key and secret management, wi-fi configurations, shell and browser history, etc. This is already in progress, steps in the right direction in `encephalon/network.nix` at the moment.

## Structure

- flake.nix: a relatively typical Nix flake, takes in some inputs, configures nix a bit, and outputs my assorted configurations
- nix: houses all system-side (non-home-manager) configuration
  - cerebrum: configuration specific to my home desktop
  - encephalon: configuration specific to my main laptop
  - shared: all generic configurations shared between machines
- home: houses all configurations managed by home manager
  - cerebrum: configuration specific to my home desktop
  - encephalon: configuration specific to my main laptop
  - shared: all generic configurations shared between machines
- secrets: manages agenix secrets, not directly imported into config
- pkgs: houses all my custom-defined packages either not in nixpkgs or customized by me
  - dnd-tools: WIP install of 5e.tools site
  - mullvad-vpn: used when nixpkgs is behind latest release
  - warp-terminal: used when nixpkgs is behind latest release
- modules: houses all my custom NixOS and home manager modules
  - nixos: system-side modules
    - fhs: options to enable running assorted non-Nix binaries
    - idevice: simple enable of iOS device support
    - pyclock: BROKEN overclock Nvidia cards with python
  - home-manager: home-side modules
    - sidebery-css: custom CSS for vertical tabs in Firefox
- overlays: defines a custom overlay to import my packages and such

## Installation

**This section is currently incomplete!** I would highly recommend *not* directly installing this configuration if you are not me. It contains settings highly tailored to my specific preferences and hardware, as well as some very experimental modules. These installation steps are merely documentation of my own install process.

1. Acquire a fresh NixOS unstable iso https://channels.nixos.org/nixos-unstable/latest-nixos-minimal-x86_64-linux.iso or build one of the custom iso's provided in my flake
2. Write it to a flash drive, I tend to use Fedora Media Writer or just `dd if=/path/to/nixos.iso of=/path/to/device` but I think the iso will boot if you just copy it to the root of a removable drive
3. Boot the installer and switch to the root user with `sudo su -`
4. If using a generic Nix image, get a Nix shell with the required tools `nix-shell -p git nixFlakes` (and anything else, maybe an editor that isn't `nano`)
5. Theoretically at this point it should be possible to just run `nix run 'github:nix-community/disko#disko-install' -- --write-efi-boot-entries --flake 'github:SonarMonkey/meninx#HOST' --disk main /path/to/disk` but this is currently untested
6. If the above didn't work, clone the config somewhere convenient on the live system
7. Format partitions, manually or via [Disko](https://github.com/nix-community/disko) with the command line tool
8. Optionally, copy the entire configuration to the new partition, like `/mnt/etc/nixos`, then `cd` to the root of wherever it went
9. Install the system with the official installer tool, like `nixos-install --root /mnt --flake .#HOST`
10. Wait for the install to finish, set your root password, and reboot

## Credits

### Inspiration

- https://github.com/hlissner/dotfiles for initially inspiring me to explore Nix, and a great list of learning resources
- https://github.com/Misterio77/nix-starter-configs for some good ideas about developing and structuring a Nix configuration regardless of complexity
- https://github.com/Misterio77/nix-config for an invaluable example of a much larger and more elaborate configuration
- https://github.com/nix-community/impermanence for inspiration about what becomes possible with NixOS

### Tools

- https://github.com/danth/stylix for excellent system-wide theming
- https://github.com/viperML/nh for a very lovely Nix update helper tool
- https://github.com/NixOS/nixos-hardware for extremely convenient pre-defined hardware configurations
- https://github.com/fufexan/nix-gaming for some very useful gaming tools and configs
- https://github.com/nix-community/disko for Nix-ifying the partitioning process
- https://nur.nix-community.org/repos/rycee for maintaining a repo of FireFox extensions for Nix
- https://github.com/ryantm/agenix for making secret management much easier
- https://github.com/kamadorueda/alejandra for making my Nix code pretty
- https://github.com/nix-community/nurl for making fetcher calls easier
- https://cachix.org for ensuring I don't have to build everything all the time
- https://github.com/MrOtherGuy/firefox-csshacks for an awesome collection of much-needed tweaks

### Resources

- https://wiki.nixos.org
- https://nixos.wiki
- https://noogle.dev
- https://home-manager-options.extranix.com
- https://search.nixos.org
- https://nur.nix-community.org
- https://nixos.org/manual/nixos/unstable/index.html
- https://nixos.org/manual/nixpkgs/unstable
- https://github.com/nix-community/awesome-nix
- https://github.com/mikeroyal/NixOS-Guide