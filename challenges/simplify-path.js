// Solution for:
// https://app.codesignal.com/challenge/9AeCgehzor6jPN6ZK

function simplifyPath(path) {
  return (
    "/" +
    path
      .split("/")
      .reduce(
        (newPath, current) =>
          current === "" || current === "."
            ? newPath
            : current === ".."
              ? newPath.slice(0, newPath.length - 1)
              : newPath.concat(current),
        []
      )
      .join("/")
  );
}
