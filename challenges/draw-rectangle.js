// Solution for:
// https://app.codesignal.com/challenge/n5QyAqtTZazRJiC75

function drawRectangle(canvas, [x1, y1, x2, y2]) {
  function isInCornerColumn(x) {
    return x === x1 || x === x2;
  }
  function isInCornerRow(y) {
    return y === y1 || y === y2;
  }
  function isCorner(x, y) {
    return isInCornerColumn(x) && isInCornerRow(y);
  }
  return canvas.map((row, y) =>
    row.map(
      (cell, x) =>
        isCorner(x, y)
          ? "*"
          : isInCornerRow(y) && x > x1 && x < x2
            ? "-"
            : isInCornerColumn(x) && y > y1 && y < y2 ? "|" : cell
    )
  );
}
