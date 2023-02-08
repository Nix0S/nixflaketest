# Plus Ultra

<a href="https://nixos.wiki/wiki/Flakes" target="_blank">
	<img alt="Nix Flakes Ready" src="https://img.shields.io/static/v1?logo=nixos&logoColor=d8dee9&label=Nix%20Flakes&labelColor=5e81ac&message=Ready&color=d8dee9&style=for-the-badge">
</a>
<a href="https://github.com/snowfallorg/lib" target="_blank">
	<img alt="Built With Snowfall" src="https://img.shields.io/static/v1?logoColor=d8dee9&label=Built%20With&labelColor=5e81ac&message=Snowfall&color=d8dee9&style=for-the-badge">
</a>

<p>
<!--
	This paragraph is not empty, it contains an em space (UTF-8 8195) on the next line in order
	to create a gap in the page.
-->
  
</p>

> ✨ Go even farther beyond.

- [Screenshots](#screenshots)
- [Overlays](#overlays)
- [Packages](#packages)
  - [`firefox-nordic-theme`](#firefox-nordic-theme)
  - [`list-iommu`](#list-iommu)
  - [`nix-update-index`](#nix-update-index)
  - [`nixos-option`](#nixos-option)
  - [`nixos-revision`](#nixos-revision)
  - [`wallpapers`](#wallpapers)
  - [`xdg-open-with-portal`](#xdg-open-with-portal)
- [Options](#options)

## Screenshots

![clean](./assets/clean.png)

![launcher](./assets/launcher.png)

![busy](./assets/busy.png)

![firefox](./assets/firefox.png)

## Overlays

See the following example for how to apply overlays from this flake.

```nix
{
	description = "";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/release-22.05";
		unstable.url = "github:nixos/nixpkgs";

		snowfall-lib = {
			url = "github:snowfallorg/lib";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		elements = {
			url = "github:jakehamilton/config";
			inputs.nixpkgs.follows = "nixpkgs";
			inputs.unstable.follows = "unstable";
		};
	};

	outputs = inputs:
		inputs.snowfall-lib.mkFlake {
			inherit inputs;

			src = ./.;

			overlays = with inputs; [
				# Get all of the packages from this flake by using the main overlay.
				elements.overlay

				# Individual overlays can be accessed from
				# `elements.overlays.<name>`.
				elements.overlays.chromium
				elements.overlays.comma
				elements.overlays.default
				elements.overlays.deploy-rs
				elements.overlays.firefox
				elements.overlays.flyctl
				elements.overlays.gnome
				elements.overlays.kubecolor
				elements.overlays.linux
				elements.overlays.lutris
				elements.overlays.nordic
				elements.overlays.obs
				elements.overlays.pocketcasts
				elements.overlays.prismlauncher
				elements.overlays.tmux

				# Individual overlays for each package in this flake
				# are available for convenience.
				elements.overlays."package/at"
				elements.overlays."package/doukutsu-rs"
				elements.overlays."package/firefox-nordic-theme"
				elements.overlays."package/frappe-books"
				elements.overlays."package/hey"
				elements.overlays."package/infrared"
				elements.overlays."package/kalidoface"
				elements.overlays."package/list-iommu"
				elements.overlays."package/nix-get-protonup"
				elements.overlays."package/nix-update-index"
				elements.overlays."package/nixos-option"
				elements.overlays."package/nixos-revision"
				elements.overlays."package/wallpapers"
				elements.overlays."package/xdg-open-with-portal"
			];
		};
}
```

## Packages

Packages can be used directly from the flake.

```nix
{
	description = "";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/release-22.05";
		unstable.url = "github:nixos/nixpkgs";

		snowfall-lib = {
			url = "github:snowfallorg/lib";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		elements = {
			url = "github:jakehamilton/config";
			inputs.nixpkgs.follows = "nixpkgs";
			inputs.unstable.follows = "unstable";
		};
	};

  outputs = inputs:
		inputs.snowfall-lib.mkFlake {
			inherit inputs;

			src = ./.;

			outputs-builder = channels:
				let
					inherit (channels.nixpkgs) system;
					inherit (elements.packages.${system})
						hey
						titan
						nixos-option
						nixos-revision
						xdg-open-with-portal;
				in {
					# ...
				};
		};
}
```

### [`at`](./packages/at/default.nix)

[`@`](https://npm.im/@suchipi/at-js) - JavaScript stdio transformation tool.

### [`doukutsu-rs`](./packages/doukutsu-rs/default.nix)

[`doukutsu-rs`](https://github.com/doukutsu-rs/doukutsu-rs) - A fully playable re-implementation of Cave Story (Doukutsu Monogatari) engine written in Rust.

### [`firefox-nordic-theme`](./packages/firefox-nordic-theme/default.nix)

[A dark theme for Firefox](https://github.com/EliverLara/firefox-nordic-theme) created using the [Nord](https://github.com/arcticicestudio/nord) color palette.

### [`frappe-books`](./packages/frappe-books/default.nix)

The AppImage build of [Frappe Books](https://frappebooks.com).

### [`hey`](./packages/hey/default.nix)

A Firefox wrapper for [HEY](https://hey.com).

### [`infrared`](./packages/infrared/default.nix)

A Minecraft [reverse proxy](https://github.com/haveachin/infrared).

### [`kalidoface`](./packages/kalidoface/default.nix)

Runs [Kalidoface](https://kalidoface.com) in Firefox.

### [`list-iommu`](./packages/list-iommu/default.nix)

A helper script to list IOMMU devices.

### [`nix-get-protonup`](./packages/nix-get-protonup/default.nix)

A helper script to install [Proton GE](https://github.com/GloriousEggroll/proton-ge-custom).

### [`nix-update-index`](./packages/nix-update-index/default.nix)

A helper script to fetch the latest index for nix-locate.

### [`nixos-option`](./packages/nixos-option/default.nix)

A flake-enabled version of `nixos-option`.

### [`nixos-revision`](./packages/nixos-revision/default.nix)

A helper script to get the configuration revision of the current system.

### [`steam`](./packages/steam/default.nix)

Extra desktop items for Steam to launch the application in Pipewire mode
or enable the gamepad UI.

### [`titan`](./packages/titan/default.nix)

A JavaScript [monorepo management tool](https://npm.im/@jakehamiton/titan).

### [`twitter`](./packages/twitter/default.nix)

A Firefox wrapper for Twitter.

### [`ubports-installer`](https://devices.ubuntu-touch.io/installer)

Install Ubuntu Touch on mobile devices.

### [`ubports-installer-udev-rules`](https://docs.ubports.com/en/latest/userguide/install.html#missing-udev-rules)

`udev` rules to allow `ubports-installer` to recognize devices.

### [`wallpapers`](./packages/wallpapers/default.nix)

A collection of wallpapers.

### [`xdg-open-with-portal`](./packages/xdg-open-with-portal/default.nix)

A replacement for `xdg-open` that fixes issues when using xwayland.

## Options

> _options documentation in progress._
