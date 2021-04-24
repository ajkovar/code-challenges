It can be easily solved with the use of concepts like inversion and parity.

## Simple Explanation:

### Inversion: 

Let us assume that there is an array of length n. For any index (i < j < n) if there is arr[ i ] > arr[ j ] i.e, if there is an element which is less than the current element on its right side, then there is an inversion.

The number of inversions on a particular element = Number of elements whose values are less than the current element and they are on the right side on the current element in the array.

Let p(i) = Number of inversions on ith element of an array.

So, the total number of inversions on complete array = p(0) + p(1) + p(2) + ..... + p(n-1).

you can effectively calculate the number of inversions using Merge Sort, segment Tree and Fenwick tree etc.

#### Effective method for counting inversions:

https://www.geeksforgeeks.org/counting-inversions/

### What is parity? Parity is either even parity or odd parity.

odd parity: A permutation(or set) of numbers is said to have an odd parity if the number of inversions on array is odd and similarly for even parity.

why? Because, if there are k number of inversions, then you definitely have to swap at least k times in order to get the sorted array. If k is odd, then even number of swaps cannot make the array sorted and similarly if k is even, then odd number of swaps cannot make the array sorted.

No matter in which order (or in any way) you swap the elements you will always get an odd number of swaps in order to sort the array completely if it has odd parity and similarly if there is even parity then, you will always get even number of swaps when you sort the array.

So, in this question, we have to take any 3( let us make it as R) consecutive elements and rotate them any number of times and check whether array can be sorted or not.

If you take R consecutive elements and rotate one time, then the number of swaps is R-1 (Ex: 3<-2<-1 if you rotate one time it will get 2<-1<-3 i.e, you are swapping 3 with 2 and then with 1 i.e, 2 swaps). If you rotate two times, it will be 2*(R-1).

If you rotate n times, then the number of swaps = n*(R-1). hence, the number of swaps you are making will always be a multiple of R-1.

So, in order to check if the array can ever be sorted by rotating R consecutive elements until it gets sorted, then the number of inversions should be divisible by R-1. because the number of inversions is nothing but the number of swaps you have to make to get the array sorted. If you can make those many number of swaps using the multiple of R-1(i.e, by rotating n number of times), then we can say that there is a value (v) exists at which our array can be sorted.


### Additional resources

- http://abstract.ups.edu/aata/aata-toc.html
- http://www2.math.umd.edu/~jcohen/402/Pinter%20Algebra.pdf
- https://stackoverflow.com/questions/337664/counting-inversions-in-an-array#:~:text=The%20number%20of%20inversions%20in,)%20time%2C%20which%20is%20optimal.
- https://riptutorial.com/haskell/example/7552/merge-sort
- https://www.maa.org/press/periodicals/loci/joma/parity-theorem-for-permutations-introduction