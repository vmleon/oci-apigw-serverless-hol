#!/usr/bin/env zx

import {
  createFnOracleContext,
  listFnOracleContext,
  setFnApiUrl,
  setFnCompartment,
  setFnProfileName,
  setFnRegistry,
  setFnRegistryCompartment,
  useFnContext,
} from "./lib/fn.mjs";
import {
  getNamespace,
  getRegions,
  searchCompartmentIdByName,
} from "./lib/oci.mjs";
import {
  checkRequiredProgramsExist,
  printRegionNames,
  setVariableFromEnvOrPrompt,
} from "./lib/utils.mjs";

const shell = process.env.SHELL | "/bin/zsh";
$.shell = shell;
$.verbose = false;

console.log("Check dependencies...");
const dependencies = ["git", "oci", "fn"];
await checkRequiredProgramsExist(dependencies);

// TODO Check OCI CLI is configured
// TODO Check DEFAULT profile exists

const namespace = await getNamespace();

const regions = await getRegions();
const regionName = await setVariableFromEnvOrPrompt(
  "OCI_REGION",
  "OCI Region name",
  async () => printRegionNames(regions)
);
const { key } = regions.find((r) => r.name === regionName);

const contextName = "oci";

const contexts = await listFnOracleContext();
if (contexts.map((c) => c.name).includes(contextName)) {
  console.log(`Context ${contextName} already exists.`);
} else {
  console.log("Create new context with Oracle provider");
  await createFnOracleContext(contextName);
}
console.log();

console.log(`Use context ${contextName}`);
await useFnContext(contextName);
console.log();

console.log("Set DEFAULT profile to context");
await setFnProfileName();
console.log();

console.log("Set compartment to context");
const compartmentName = await question(chalk.cyan("Compartment Name: "));
const compartmentId = await searchCompartmentIdByName(compartmentName);
await setFnCompartment(compartmentId);
console.log();

console.log("Set Functions API URL to context");
await setFnApiUrl(key);
console.log();

console.log("Set Functions registry to context");
const repoNamePrefix = await question(chalk.cyan("Repo name prefix: "));
await setFnRegistry(key, namespace, repoNamePrefix);
console.log();

console.log("Set Functions registry compartment to context");
await setFnRegistryCompartment(compartmentId);
console.log();
