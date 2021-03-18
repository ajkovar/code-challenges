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

function checkDuplicates(numbers) {
    const counts = [];
    for(var i=0; i<numbers.length; i++) {
        if(counts[number])  {
            return false;
        }
        counts[number] = 1;
    }
    return true;
}

/*
 * Complete the 'partitionArray' function below.
 *
 * The function is expected to return a STRING.
 * The function accepts following parameters:
 *  1. INTEGER k
 *  2. INTEGER_ARRAY numbers
 */

function partitionArray(k, numbers) {
    // Write your code here

}

function main() {
    const ws = fs.createWriteStream(process.env.OUTPUT_PATH);

    const k = parseInt(readLine().trim(), 10);

    const numbersCount = parseInt(readLine().trim(), 10);

    let numbers = [];

    for (let i = 0; i < numbersCount; i++) {
        const numbersItem = parseInt(readLine().trim(), 10);
        numbers.push(numbersItem);
    }

    const result = partitionArray(k, numbers);

    ws.write(result + '\n');

    ws.end();
}
