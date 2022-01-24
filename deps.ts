#! /usr/bin/env deno run --allow-read --allow-write --allow-env --unstable
export { renderFile } from "https://deno.land/x/dejs/mod.ts";
export { parse } from "https://deno.land/std/flags/mod.ts";
export { exists } from "https://deno.land/std/fs/mod.ts";
export { copy } from "https://deno.land/std/streams/conversion.ts";

export const { cwd, env, args, open, exit, mkdir } = Deno;
