#! /usr/bin/env deno run --allow-read --allow-write --allow-env --unstable
import { renderFile } from "https://deno.land/x/dejs/mod.ts";
import { parse } from "https://deno.land/std/flags/mod.ts";
import { exists } from "https://deno.land/std/fs/mod.ts";

const { cwd, copy, env, args, open, exit, mkdir } = Deno;

enum SystemOptions {
  OSX = "osx",
  CENTOS = "centos",
  UBUNTU = "ubuntu",
  ARCH_LINUX = "arch",
}

const packageManagerAliases = {
  [SystemOptions.OSX]: `
    alias i="brew install"
    alias ic="brew install --cask "
    alias s="brew search"
    alias r="brew uninstall"
    alias u="brew update && brew tap homebrew/cask && brew upgrade"
  `,
  [SystemOptions.ARCH_LINUX]: `
    alias i="yay -Sy --noconfirm"
    alias s="yay -Ss"
    alias r="yay -Rsc"
    alias u="yay -Syu; npm i -g npm; yay -Rns $(yay -Qtdq | tr '\\n' ' ')"
  `,
  [SystemOptions.UBUNTU]: `
    alias i="sudo apt install -y"
    alias u="sudo apt update && sudo apt upgrade && sudo apt dist-upgrade && sudo apt autoremove"
    alias s="sudo apt search"
    alias r="sudo apt purge"
  `,
  [SystemOptions.CENTOS]: `
    alias i="sudo yum install -y"
    alias u="sudo yum check-update && sudo yum update && sudo yum clean all"
    alias s="sudo yum search"
    alias r="sudo yum remove"
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

  const operationSystem: SystemOptions = systemArg as SystemOptions;
  const packageManager = packageManagerAliases[operationSystem];

  const destFolder = parsedArgs.o || env.get("HOME");
  const currentDir = cwd();

  if (destFolder && !(await exists(destFolder))) {
    await mkdir(parsedArgs.o);
  }

  const files = [
    [`${currentDir}/templates/zshrc`, `${destFolder}/.zshrc`],
    [`${currentDir}/templates/aliases`, `${destFolder}/.aliases`],
    [`${currentDir}/templates/amazon-aliases`, `${destFolder}/.amazon-aliases`],
  ];

  for (const [source, dest] of files) {
    if (source.includes("amazon") && !parsedArgs.a) continue;

    const output = await renderFile(source, {
      packageManager: packageManager,
      system: systemArg,
      amazon: parsedArgs.a,
    });

    const outputFile = await open(dest, {
      write: true,
      create: true,
      truncate: true,
    });
    await copy(output, outputFile);
  }

  console.log("Done!");
  console.log("You can a new zsh session now :)");
}

if (import.meta.main) {
  await main();
}
