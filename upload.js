const { spawnSync } = require("child_process");

const bucket = "webreplay-website";

spawnSync("npm", ["run", "prep"], { stdio: "inherit" });
spawnSync("npm", ["run", "build"], { stdio: "inherit" });
spawnSync("aws", [
  "s3",
  "cp",
  "--recursive",
  "protocol",
  `s3://${bucket}/protocol`
], { stdio: "inherit" });
