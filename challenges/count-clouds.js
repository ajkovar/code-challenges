function countClouds(skyMap) {
  const isAdjacent = (cloud, x, y) =>
    cloud.some(
      ([cloudX, cloudY]) => Math.abs(cloudX - x) + Math.abs(cloudY - y) < 2
    );
  const clouds = [];
  skyMap.forEach((row, y) =>
    row.forEach((cell, x) => {
      if (cell === "1") {
        const existing = clouds.find(otherCloud =>
          isAdjacent(otherCloud, x, y)
        );
        if (!existing) {
          clouds.push([[x, y]]);
        } else {
          existing.push([x, y]);
        }
      }
    })
  );
  const mergedClouds = [];
  clouds.forEach((cloud, i) => {
    const adjacent = mergedClouds.find(otherCloud =>
      otherCloud.some(([x, y]) => isAdjacent(cloud, x, y))
    );

    if (adjacent) {
      adjacent.push(...cloud);
    } else {
      mergedClouds.push(cloud);
    }
  });
  return mergedClouds.length;
}
