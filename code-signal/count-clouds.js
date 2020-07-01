// https://app.codesignal.com/challenge/u6ob2kqxxQpCRsHaP

function countClouds(skyMap) {
  const checked = skyMap.map(() => []);
  const traceCloud = (x, y) => {
    if (
      y < 0 ||
      y >= skyMap.length ||
      x < 0 ||
      x >= skyMap[y].length ||
      checked[y][x] ||
      skyMap[y][x] !== "1"
    ) {
      return 0;
    }
    checked[y][x] = true;
    traceCloud(x + 1, y);
    traceCloud(x - 1, y);
    traceCloud(x, y + 1);
    traceCloud(x, y - 1);
    return 1;
  };

  return skyMap.reduce(
    (sum, row, y) =>
      sum + row.reduce((rowSum, cell, x) => rowSum + traceCloud(x, y), 0),
    0
  );
}
