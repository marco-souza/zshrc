#! /usr/bin/env deno run --allow-read --allow-write --allow-env --unstable
import { parse, args, copy, cwd, env, exists, exit, mkdir, open, renderFile } from "./deps.ts";
import { PACKAGE_MANAGER_ALIASES, OS } from "./settings.ts";

async function main() {
  const parsedArgs = parse(args);
  const systemArg = parsedArgs.system || parsedArgs.s;

  if (!systemArg) {
    console.log("Please, specify a operational system with -s.");
    console.log(`  options: ${Object.keys(PACKAGE_MANAGER_ALIASES).join("|")}`);
    exit(1);
  }

  const system: OS = systemArg;
  const packageManager = PACKAGE_MANAGER_ALIASES[system];

  const destFolder = parsedArgs.o || env.get("HOME");
  const currentDir = cwd();

  if (destFolder && !(await exists(destFolder))) {
    await mkdir(parsedArgs.o);
  }

  const supportJava = parsedArgs.java;
  const files = [
    [`${currentDir}/templates/profile`, `${destFolder}/.profile`],
    [`${currentDir}/templates/zshrc`, `${destFolder}/.zshrc`],
    [`${currentDir}/templates/aliases`, `${destFolder}/.aliases`],
    [`${currentDir}/templates/paradigm.aliases`, `${destFolder}/.paradigm.aliases`],
  ];

  const osWithSnapSupport: OS[] = ["arch", "ubuntu"];
  const supportSnap = osWithSnapSupport.includes(systemArg);

  const paradigmAliases = parsedArgs.p;

  for (const [source, dest] of files) {
    const output = await renderFile(source, {
      system,
      packageManager,
      supportJava,
      supportSnap,
      paradigmAliases,
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
