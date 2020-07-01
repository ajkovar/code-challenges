// solution for:
// https://app.codesignal.com/challenge/GKx9cCWATHPWpvnKQ
function squaresUnderQueenAttack(n, queens, queries) {
  return queries.map(([x, y]) =>
    queens.some(
      ([queenX, queenY]) =>
        queenX === x ||
        queenY === y ||
        Math.abs(x - queenX) === Math.abs(y - queenY)
    )
  );
}
