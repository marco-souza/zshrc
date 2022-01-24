export type OS = "osx" | "arch" | "ubuntu";

export const PACKAGE_MANAGER_ALIASES: Record<OS, string> = {
  osx: `
    alias i="brew install"
    alias ic="brew install --cask "
    alias s="brew search"
    alias r="brew uninstall"
    alias u="brew update && brew tap homebrew/cask && brew upgrade"
  `,
  arch: `
    alias i="yay -Sy --noconfirm"
    alias s="yay -Ss"
    alias r="yay -Rsc"
    alias u="yay -Syu; npm up -g npm; sudo deno upgrade"
  `,
  ubuntu: `
    alias i="sudo apt install -y"
    alias u="sudo apt update && sudo apt upgrade && sudo apt dist-upgrade && sudo apt autoremove"
    alias s="sudo apt search"
    alias r="sudo apt purge"
  `,
};
