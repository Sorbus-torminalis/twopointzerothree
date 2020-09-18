
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

`twopointzerothree` requires a vector of numbers as input.

``` r
library(twopointzerothree)
data("kp2014")# part of the data from Keiser & Pruitt 2014
sequence_find_all(vec = kp2014$`Theridion murarium Aggressiveness...4`)
#>    duplicate_no length pos1   vec1 pos2   vec2 delta
#> 1             1      9   67 166.26   78 161.91 -4.35
#> 2             1      9   68  47.68   79  43.33 -4.35
#> 3             1      9   69 124.67   80 120.32 -4.35
#> 4             1      9   70  90.98   81  86.63 -4.35
#> 5             1      9   71 134.36   82 130.01 -4.35
#> 6             1      9   72 157.67   83 153.32 -4.35
#> 7             1      9   73  46.38   84  42.03 -4.35
#> 8             1      9   74 186.29   85 181.94 -4.35
#> 9             1      9   75 147.71   86 143.36 -4.35
#> 10            1      7   29  13.24   62  15.27  2.03
#> 11            1      7   30 201.65   63 203.68  2.03
#> 12            1      7   31 228.64   64 230.67  2.03
#> 13            1      7   32 645.23   65 647.26  2.03
#> 14            1      7   33  15.24   66  17.27  2.03
#> 15            1      7   34 164.23   67 166.26  2.03
#> 16            1      7   35  45.65   68  47.68  2.03
```

The result give the position and values of the first and second sets of
duplicated values and any offset.

If data in several columns need to be checked, they should be appended
into one vector.

``` r
sequence_find_all(
  vec = c(kp2014$`Theridion murarium Aggressiveness...4`,
          kp2014$`Theridion murarium Aggressiveness...5`,
          kp2014$`Theridion murarium Aggressiveness...6`))
#>    duplicate_no length pos1   vec1 pos2   vec2 delta
#> 1             1      9   67 166.26   78 161.91 -4.35
#> 2             1      9   68  47.68   79  43.33 -4.35
#> 3             1      9   69 124.67   80 120.32 -4.35
#> 4             1      9   70  90.98   81  86.63 -4.35
#> 5             1      9   71 134.36   82 130.01 -4.35
#> 6             1      9   72 157.67   83 153.32 -4.35
#> 7             1      9   73  46.38   84  42.03 -4.35
#> 8             1      9   74 186.29   85 181.94 -4.35
#> 9             1      9   75 147.71   86 143.36 -4.35
#> 10            2      9   69 124.67  127 122.64 -2.03
#> 11            2      9   70  90.98  128  88.95 -2.03
#> 12            2      9   71 134.36  129 132.33 -2.03
#> 13            2      9   72 157.67  130 155.64 -2.03
#> 14            2      9   73  46.38  131  44.35 -2.03
#> 15            2      9   74 186.29  132 184.26 -2.03
#> 16            2      9   75 147.71  133 145.68 -2.03
#> 17            2      9   76  16.39  134  14.36 -2.03
#> 18            2      9   77 123.69  135 121.66 -2.03
#> 19            1      7   29  13.24   62  15.27  2.03
#> 20            1      7   30 201.65   63 203.68  2.03
#> 21            1      7   31 228.64   64 230.67  2.03
#> 22            1      7   32 645.23   65 647.26  2.03
#> 23            1      7   33  15.24   66  17.27  2.03
#> 24            1      7   34 164.23   67 166.26  2.03
#> 25            1      7   35  45.65   68  47.68  2.03
#> 26            6      7   80 120.32  127 122.64  2.32
#> 27            6      7   81  86.63  128  88.95  2.32
#> 28            6      7   82 130.01  129 132.33  2.32
#> 29            6      7   83 153.32  130 155.64  2.32
#> 30            6      7   84  42.03  131  44.35  2.32
#> 31            6      7   85 181.94  132 184.26  2.32
#> 32            6      7   86 143.36  133 145.68  2.32
```

## Notes

`twopointzerothree` will report the all the duplicate sequences it can
find.

`twopointzerothree` will not report sequences of identical values as
duplicates as `cor(rep(1, 3), rep(2, 3))` returns NA.

If very short sequences (e.g. length 3) are searched for, there is a
high risk of false positives. These can be identified by having offset
values that are not consistent.

`twopointzerothree` reports duplicate values. It does not report why.

If you find this package useful or have ideas about how it could be
improve, please leave a message in the issues tab.
