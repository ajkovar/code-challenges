'use strict';

const fs = require('fs');

process.stdin.resume();
process.stdin.setEncoding('utf-8');

let inputString = '';
let currentLine = 0;

process.stdin.on('data', function(inputStdin) {
    inputString += inputStdin;
});

process.stdin.on('end', function() {
    inputString = inputString.split('\n');

    main();
});

function readLine() {
    return inputString[currentLine++];
}



/*
 * Complete the 'parseMessageVariables' function below.
 *
 * The function is expected to return a STRING_ARRAY.
 * The function accepts STRING message as parameter.
 */
function parseMessageVariables(message) {
  const regexp = /%([A-Za-z-]*)(:[A-Za-z]*)?%/g
  const variables = [];
  let capture;
  while(capture = regexp.exec(message)) {
      variables.push(capture[1])
  }
  return variables;
}

function main() {
    const ws = fs.createWriteStream(process.env.OUTPUT_PATH);

    const message = readLine();

    const result = parseMessageVariables(message);

    ws.write(result.join('\n') + '\n');

    ws.end();
}