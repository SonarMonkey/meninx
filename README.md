# meninx

An overly complicated flake configuration for my Nix(OS) systems. Named for a variant of the word [Meninges](https://en.wikipedia.org/wiki/Meninges), the membranes that surround the human nervous system. Years ago I started naming all my computers after parts of the brain, and when I decided to group all my Nix configurations I needed an umbrella term that was on-theme. "Meninx" fit perfectly, and also almost has the word "Nix" in it. :shrug:

## Disclaimer

This is *my personal configuration* and is not intended to be used as-is outside of my own machines. I make no guarantee that it will work out of the box, and the configuration is subject to change drastically. I'm perfectly happy to field discussion or questions (feel free to open an issue), but I'm hardly an expert on Nix/NixOS and you may have better luck on the NixOS forums. I accept no responsibility for any consequences of attempting to use this configuration for yourself. It is provided as-is for my own convenience and in hopes that it may provide an additional reference for others getting into the Nix space.

Also, note: All references to a "desktop" configuration are still technically true, but I do not use the desktop ("cerebrum") configuration at the moment. It has not been updated for some time and is disabled in the flake. It will likely be archived or completely overhauled in the future. The laptop ("encephalon") configuration is the only one that is currently maintained.

## Overview

- System Shell: bash + blesh
- User Shell: zsh + some tweaks
- Terminal: mostly kitty, may switch to alacritty
- Prompt Theme: starship preset, may remove entirely
- Desktop Manager: GNOME display manager
- Desktop Environment: GNOME on laptop
- GUI Editor: VSCode with extensions
- Terminal Editor: helix with some LSP's
- Alternate Term Editor: moderately-configured NixVim
- Theme: just adwaita-dark with adw-gtk3 for consistency

## To-Do List

- [x] Review for major errors
- [x] Review `TODO` and `FIXME` items
- [ ] Add an ISO configuration to flake
- [ ] Trim cruft packages (WIP)
- [x] Create module system (WIP)
- [x] ~~Fix `pyClock` module (resigned for now)~~
- [ ] Create "minimal" install config
- [ ] Fix package locations (mostly done)
- [x] ~~Create disko config for cerebrum (resigned for now)~~
- [ ] Add inline links/documentation (WIP)
- [ ] Add NixOS-WSL configuration
- [ ] Add more links/wiki/etc.
- [ ] Further update README.md (WIP)
- [x] Heavily pare back zsh config (prev config incl. for reference)
- [x] Switch to `programs.gnome-shell` for extensions
- [x] Add custom font configuration for encephalon

## Notes

- Themes are currently disabled, when the GNOME 46 update just hit and I did not feel like fixing things. May or may not add them back, as I honestly don't mind the default dark look of Adwaita these days.
- I'm currently in the process of heavily cleaning up this configuration, and it is likely to change drastically in the coming days. I'm getting ready to set up some new stuff, and got a little lax on my organizational theme, so things are a bit messy.

## Future Plans

- Add a more nixified way to back up or configure stuff that would be lost or manually reconfigured on a full re-install. Zoxide history, shell history(atuin?), handful of little Firefox tweaks, etc. Not super difficult, and some of the modules I have planned should solve most of these problems.
- Switch to using individual NUR repositories instead of pulling in the whole thing. Not sure that I really need to do this necessarily, but it just feels a bit better. Example documented in `flake.nix`. Mostly for rycee's NUR repo that has all the Firefox extensions in it, since I don't currently use anything else from the NUR.
- Modularize further for Nix code I'm re-using heavily, and things that don't have modules. Especially for declarative Mullvad settings, as this is currently not possible with the default module/package. Also want to look into adding a firefox-csshacks module that covers options for the whole repo. Hoping to end up contributing some of these to Nix itself.
- Use my own machines as package caches for each other in case I need/want to do a full reinstall of one, or if I get a new machine and have to set it up behind slow internet.
- Set up the old server I have lying around on Nix as well, mostly to be a better package cache instead of my main machines. Also for a bit of cloud storage and some low-demand services I'd like to run going forward. (thalamus)
- Set up a self-hosted Headscale instance. Should be easily(???) configured with NixOS, given that most of my machines (current and planned) will be running Nix as well. In general, want to self-host as much as possible going forward.
- Better document my entire configuration with actual links out to wherever I got the information, especially in weird cases like my network configuration. Alternatively, switch to an entirely literate-programming config with Org or some other tool. (this is less relevant now, my network config was silly)
- Improve overall declarative-ness, especially for key and secret management, wi-fi configurations, shell and browser history, etc. This is already in progress, steps in the right direction in `encephalon/network.nix` at the moment. (this comment is outdated, as mentioned my network config was silly, but still may update it a bit)

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
- modules: houses all my custom NixOS and home manager modules
  - nixos: system-side modules (subject to deletion)
    - fhs: options to enable running assorted non-Nix binaries
    - idevice: simple enable of iOS device support
  - home-manager: home-side modules (not working yet)
    - sidebery-css: custom CSS for vertical tabs in Firefox
- overlays: defines a custom overlay to import my packages and such
- pkgs: houses all my custom-defined packages either not in nixpkgs or customized by me
- secrets: manages agenix secrets, not directly imported into config

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
- https://wiki.nixos.org
- https://noogle.dev
- https://home-manager-options.extranix.com
- https://search.nixos.org
- https://nur.nix-community.org
- https://nixos.org/manual/nixos/unstable/index.html
- https://nixos.org/manual/nixpkgs/unstable
- https://github.com/nix-community/awesome-nix
- https://github.com/mikeroyal/NixOS-Guide