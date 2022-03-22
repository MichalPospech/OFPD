# Optimal Financial Portfolio Design

Credit assignment for NOPT042 class at Charles University

## Problem description 

On OPD problem is defined by a triplet $(v,b,r)$. The task is to find a matrix $P\in \{0,1\}^{v\times b}$ such that:
 - $max_{i\neq j}(P_{i*}\cdot P_{j*}) = \lambda$ 
 - $\forall i \sum P_{i*} = r$
 
 while minimising the value of $\lambda$. Or in other terms, we are looking for $v$ subsets of cardinality $r$ from a given set of cardinality $b$ such that the cardinality of the largest interesection of differents subsets (denoted as $\lambda$) is minimised. 

 This task was first described by [P. Flenner in 2004](https://link.springer.com/chapter/10.1007/978-3-540-30201-8_19)

 ## Model design

 The model is quite straightforward given the definition of OPD problem. There are 3 variables:
  - `portfolios` - a binary matrix (array with 2 indices) equivalent to $P$
  - `portfolios_sets` - array of sets, a subset representation of the problem
  - `lambda` - $\lambda$ as defined in the definition of OPD

First conditions are also quite straightforward. There are 2 conditions to ensure that the sum of rows of $P$ is $r$ and the subsets have cardinality $r$. Then there are 2 conditions that $\lambda$ is the maximum dot product between lines and intersection between 2 subsets. 

Then there are some conditions, that are more complex. First, the bounds on the $\lambda$ variable. The lower bound is calculated based on a Theorem 1 from a [paper](https://www.it.uu.se/research/group/astra/publications/Constraints07-CDO.pdf) by Flener.
Following that there is a symmetry breaking condition, that says, that the matrix $P$ must have both rows and columns in lexicographic order. This can be done thanks to the Theorem 2 from [paper](http://www.it.uu.se/research/group/astra/SymCon02/Proceedings/KiziltanSmith.pdf) by Kiltzian which applies because the row-sums are constant.

Last there is a channeling constraint that joins the set and matrix representations of the problem. This may help the solver by allowing it to use 2 types of conditions.
## Results
???