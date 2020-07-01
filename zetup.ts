#! /usr/bin/env deno run --allow-read --allow-write --allow-env
import { renderFile } from "https://deno.land/x/dejs/mod.ts";
import { parse } from "https://deno.land/std/flags/mod.ts";

const { cwd, stdout, copy } = Deno;

enum SystemOptions {
  OSX = "osx",
  UBUNTU = "ubuntu",
  ARCH_LINUX = "arch",
}

const packageManagerAliases = {
  [SystemOptions.OSX]: `
    alias i="brew install"
    alias ic="brew cask install"
    alias s="brew search"
    alias r="brew uninstall"
    alias u="brew update && brew tap homebrew/cask && brew upgrade"
  `,
  [SystemOptions.ARCH_LINUX]: `
    #alias i="yay -Sy"
    #alias s="yay -Ss"
    #alias r="yay -Rsc"
    #alias u="yay -Syu; npm i -g npm; yay -Rns $(yay -Qtdq | tr '\n' ' ')"
  `,
  [SystemOptions.UBUNTU]: `
    #alias i="sudo apt install -y"
    #alias u="sudo apt update && sudo apt upgrade && sudo apt dist-upgrade && sudo apt autoremove"
    #alias s="sudo apt search"
    #alias r="sudo apt purge"
  `,
};

async function main() {
  const parsedArgs = parse(Deno.args);
  const systemArg = parsedArgs.system || parsedArgs.s;

  if (!systemArg) {
    console.log("Please, specify a operational system with -s.");
    console.log(`  options: ${Object.keys(packageManagerAliases).join("|")}`);
    Deno.exit(1);
  }

  const operationSystem: SystemOptions = systemArg as SystemOptions;
  const packageManager = packageManagerAliases[operationSystem];

  const home = Deno.env.get("HOME");
  const currentDir = cwd();

  const files = [
    [`${currentDir}/templates/amazon-aliases`, `${home}/.amazon-aliases`],
    [`${currentDir}/templates/aliases`, `${home}/.aliases`],
    [`${currentDir}/templates/zshrc`, `${home}/.zshrc`],
  ];

  for (const [source, dest] of files) {
    if (source.includes("amazon") && !parsedArgs.a) continue;

    console.log(source, dest);
    const output = await renderFile(source, {
      packageManager: packageManager,
      system: systemArg,
      amazon: parsedArgs.a,
    });

    const outputFile = await Deno.open(dest, {
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
