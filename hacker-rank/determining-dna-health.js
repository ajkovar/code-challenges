"use strict";

process.stdin.resume();
process.stdin.setEncoding("utf-8");

let inputString = "";
let currentLine = 0;

process.stdin.on("data", (inputStdin) => {
  inputString += inputStdin;
});

process.stdin.on("end", (_) => {
  inputString = inputString
    .replace(/\s*$/, "")
    .split("\n")
    .map((str) => str.replace(/\s*$/, ""));

  main();
});

function readLine() {
  return inputString[currentLine++];
}

function getHealthValue({ genes, health, first, last, sequence }) {
  let value = 0;
  for (var i = 0; i < sequence.length; i++) {
    for (let j = first; j <= last; j++) {
      if (sequence.slice(i, i + genes[j].length) === genes[j]) {
        value += health[j];
      }
    }
  }
  return value;
}

function main() {
  const n = parseInt(readLine(), 10);

  const genes = readLine().split(" ");

  const health = readLine()
    .split(" ")
    .map((healthTemp) => parseInt(healthTemp, 10));

  const s = parseInt(readLine(), 10);

  let max = 0;
  let min = Infinity;
  for (let sItr = 0; sItr < s; sItr++) {
    const firstLastd = readLine().split(" ");

    const first = parseInt(firstLastd[0], 10);

    const last = parseInt(firstLastd[1], 10);

    const d = firstLastd[2];
    const value = getHealthValue({ genes, health, first, last, sequence: d });

    max = Math.max(max, value);
    min = Math.min(min, value);
  }
  console.log([min === Infinity ? 0 : min, max].join(" "));
}
