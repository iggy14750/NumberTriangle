#Minimum-Sum Numeric Triangle

####**Problem:**

This prompt was lifted from [Project Euler #150](https://projecteuler.net/problem=150).  While anyone in need of a full explanation of the problem should follow the link, in a word, it works like this: arrange a bunch of positive numbers into a pyramid or triangle, and pick the triangle within the whole with the sum of its members being less than any of the others'.  Again, for a detailed description of the problem, see the page above.

####Details

This project belongs to Isaac B Goss and Kyle Legters for our COE 0147 Computer Organization and Assembly Language midterm project.  

"Psuedo"-code in this document will probably be recorded in Python, although the project is implemented in Java and then MIPS assembly.  A useful Python module is also provided to calculate some things regarding this project.

[GENERATING TEST CASES]

[PROVING THAT THERE IS NO SILVER BULLET]

####Row Sum Algorithm

This algorithm attempts to do as much math as possible upfront before beginning to compare sub-triangles (sub-ts).  The method involves finding the partial sums of each row as one might move from left to right.  For example,
```
my_triangle = [[1],
              [2,3],
              [4,5,6],
              [7,8,9,0]]
```
Let's take the partial sum of the first row.
```
mySum[0] = [0,...
```
We begin each sum at zero, a useful convention, as we'll come to see.
```
mySum[0] = [0,1]
```
This is all that is in the first row, so we terminate, and move on to the next.
```
mySum[1] = [0,2,...
```
Now, the next element is the sum of the previous and current elements in this row, namely, 2 and 3.
```
mySum[1] = [0,2,(2+3)] # ie, [0,2,5]
```
I think you've got the idea.  The whole thing looks like this.
```
mySum = [[0,1],
        [0,2,5],
        [0,4,9,15],
        [0,7,15,24,24]]
```

Now, what do we do with this?  We have now done a huge portion of the math needed to solve this problem, work which will now only need to be done once.
Now, we need to choose the best sub-t.  This means that each and every possible sub-t of our data set needs to be considered.  This could become really quite computationally intensive with 1000 rows.  In particular, there exist 167,167,000 sub-ts of a 1000 row set, of various sizes.  But, now that we have done this relatively simple set-up step, we can drastically reduce the work which needs to be repeated.

So, how is this done?  Each sub-t is chosen with repect to its apex, its top point, and its height.  For instance, we can choose the sub-t (1,1,3) from `my_triangle` which looks like this.
```
[[3],
[5,6],
[8,9,0]]
```
We then find the sum of these elements.  Slightly more generally, the sum of each sub-t is also the sum of its rows.
The important realization here is that `sum(sub_t(1,1,3)) = sum(sub_t(1,1,2)) + sum(bottom_row(1,1,3))`.  In other words, we can reuse more work. 
Okay, now about these rows.  That `mySum` above has all the information we need.  Why's that?  Each element of this structure represents the partial sum as you walk left to right across each row, so any segment we need can be represented as the difference between the ending and beginning partial sum.  Maybe an example? Okay.

We can start with the first row in (1,1,3).
```
this_row = mySum[1][2] - mySum[1][1] # 3 = 5 - 2
```
The last row might shed some more light on this
```
this_row = mySum[3][4] - mySum[3][1] # 17 = 24 - 7 = 8 + 9 + 0
```
This is how we choose just the part of the row we need, by first choosing our right-most bound and subtracting anything before our left-most bound.

The rest is a matter of comparison and keeping the current winner.

####MIPS Assembly Details

####Conclusion

[RESULTS WILL BE PLACED HERE]
