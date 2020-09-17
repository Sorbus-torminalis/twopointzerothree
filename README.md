
<!-- README.md is generated from README.Rmd. Please edit that file -->

# twopointzerothree

<!-- badges: start -->

<!-- badges: end -->

`twopointzerothree` is motivated by an [expression of
concern](https://pubpeer.com/publications/BF638A197BC80D145674D8118BE37F)
concerning a paper coauthored by Dr Pruitt following the discovery,
amongst other issues, that

> Seven consecutive values from *Theridon* agressiveness assay \#1
> differ exactly by + 2.03 from another exact sequence in aggressiveness
> assay \#1 in a different treatment group

I wanted to know how this could be done. As far as I know, standard
tools (n-grams) only detect duplicate sequences, not duplicate sequences
with an offset.

`twopointzerothree` develops a method for detecting duplicate offset
sequences by searching for repeat sequences of perfectly correlated
numbers. These repeat sequences are either duplicates or offset
duplicates.

`twopointzerothree` can be installed with

``` r
remotes::install_github("Sorbus-torminalis/twopointzerothree.git")
```

`twopointzerothree` requires a vector of numbers as input and the
maximum length of duplicate to search for (`sequence_longest` can report
the length of the longest).

``` r
library(twopointzerothree)
data("kp2014")# part of the data from Keiser & Pruitt 2014
sequence_find(vec = kp2014$`Theridion murarium Aggressiveness...4`, max = 9)
#> longest duplicate length = 9
#>   duplicate_no pos1   vec1 pos2   vec2 delta
#> 1            1   67 166.26   78 161.91 -4.35
#> 2            1   68  47.68   79  43.33 -4.35
#> 3            1   69 124.67   80 120.32 -4.35
#> 4            1   70  90.98   81  86.63 -4.35
#> 5            1   71 134.36   82 130.01 -4.35
#> 6            1   72 157.67   83 153.32 -4.35
#> 7            1   73  46.38   84  42.03 -4.35
#> 8            1   74 186.29   85 181.94 -4.35
#> 9            1   75 147.71   86 143.36 -4.35
```

The result give the position and values of the first and second sets of
duplicated values and any offset.

If data in several columns need to be checked, they should be appended
into one vector.

``` r
sequence_find(
  vec = c(kp2014$`Theridion murarium Aggressiveness...4`,
          kp2014$`Theridion murarium Aggressiveness...5`,
          kp2014$`Theridion murarium Aggressiveness...6`),
  max = 9)
#> longest duplicate length = 9
#>    duplicate_no pos1   vec1 pos2   vec2 delta
#> 1             1   67 166.26   78 161.91 -4.35
#> 2             1   68  47.68   79  43.33 -4.35
#> 3             1   69 124.67   80 120.32 -4.35
#> 4             1   70  90.98   81  86.63 -4.35
#> 5             1   71 134.36   82 130.01 -4.35
#> 6             1   72 157.67   83 153.32 -4.35
#> 7             1   73  46.38   84  42.03 -4.35
#> 8             1   74 186.29   85 181.94 -4.35
#> 9             1   75 147.71   86 143.36 -4.35
#> 10            2   69 124.67  127 122.64 -2.03
#> 11            2   70  90.98  128  88.95 -2.03
#> 12            2   71 134.36  129 132.33 -2.03
#> 13            2   72 157.67  130 155.64 -2.03
#> 14            2   73  46.38  131  44.35 -2.03
#> 15            2   74 186.29  132 184.26 -2.03
#> 16            2   75 147.71  133 145.68 -2.03
#> 17            2   76  16.39  134  14.36 -2.03
#> 18            2   77 123.69  135 121.66 -2.03
```

## Notes

`twopointzerothree` will report the longest sequence of duplicates
sequences it can find that are at most `max` elements long. To find
shorter sequences, reduce `max`. If `max` is less than the length of the
longest sequence, it `sequence_find` will return overlapping sequences.

`twopointzerothree` will not report sequences of identical values as
duplicates as `cor(rep(1, 3), rep(2, 3))` returns NA.

`twopointzerothree` reports duplicate values. It does not report why.

If you find this package useful or have ideas about how it could be
improve, please leave a message in the issues tab.
