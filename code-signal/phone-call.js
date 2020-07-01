// Solution for:
// https://app.codesignal.com/challenge/puDZcNZBgcqdhXuAD

function phoneCall(min1, min2_10, min11, s) {
  function time(cost, balance, max) {
    return Math.min(Math.floor(balance / cost), max);
  }
  return [[min1, 1], [min2_10, 9], [min11, Infinity]].reduce(
    ([minutes, balance], [cost, max]) => {
      const addedTime = time(cost, balance, max);
      return [
        minutes + addedTime,
        addedTime < max ? 0 : balance - addedTime * cost
      ];
    },
    [0, s]
  )[0];
}
