#! /usr/bin/env deno run --allow-read --allow-write --allow-env --unstable
import { renderFile } from "https://deno.land/x/dejs/mod.ts";
import { parse } from "https://deno.land/std/flags/mod.ts";
import { exists } from "https://deno.land/std/fs/mod.ts";

const { cwd, copy, env, args, open, exit, mkdir } = Deno;

enum OS {
  OSX = "osx",
  UBUNTU = "ubuntu",
  ARCH_LINUX = "arch",
}

const packageManagerAliases = {
  [OS.OSX]: `
    alias i="brew install"
    alias ic="brew install --cask "
    alias s="brew search"
    alias r="brew uninstall"
    alias u="brew update && brew tap homebrew/cask && brew upgrade"
  `,
  [OS.ARCH_LINUX]: `
    alias i="yay -Sy --noconfirm"
    alias s="yay -Ss"
    alias r="yay -Rsc"
    alias u="yay -Syu; npm up -g npm; deno upgrade"
  `,
  [OS.UBUNTU]: `
    alias i="sudo apt install -y"
    alias u="sudo apt update && sudo apt upgrade && sudo apt dist-upgrade && sudo apt autoremove"
    alias s="sudo apt search"
    alias r="sudo apt purge"
  `,
};

async function main() {
  const parsedArgs = parse(args);
  const systemArg = parsedArgs.system || parsedArgs.s;

  if (!systemArg) {
    console.log("Please, specify a operational system with -s.");
    console.log(`  options: ${Object.keys(packageManagerAliases).join("|")}`);
    exit(1);
  }

  const system: OS = systemArg as OS;
  const packageManager = packageManagerAliases[system];

  const destFolder = parsedArgs.o || env.get("HOME");
  const currentDir = cwd();

  if (destFolder && !(await exists(destFolder))) {
    await mkdir(parsedArgs.o);
  }

  const files = [
    [`${currentDir}/templates/zshrc`, `${destFolder}/.zshrc`],
    [`${currentDir}/templates/aliases`, `${destFolder}/.aliases`],
  ];

  for (const [source, dest] of files) {
    const output = await renderFile(source, {
      system,
      packageManager,
      supportSnap: [OS.ARCH_LINUX, OS.UBUNTU].includes(systemArg),
    });

    const outputFile = await open(dest, {
      write: true,
      create: true,
      truncate: true,
    });
    await copy(output, outputFile);
  }

  console.log("Done, you are good to go!");
  console.log("You can start a new zsh session now :)");
}

if (import.meta.main) {
  await main();
}
