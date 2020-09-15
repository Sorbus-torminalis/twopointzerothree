
<!-- README.md is generated from README.Rmd. Please edit that file -->

# twopointzerothree

<!-- badges: start -->

<!-- badges: end -->

twopointzerothree is motivated by an [expression of
concern](https://pubpeer.com/publications/BF638A197BC80D145674D8118BE37F)
concerning a paper coauthored by Dr Pruitt following the discovery,
amongst other issues, that

> Seven consecutive values from *Theridon* agressiveness assay \#1
> differ exactly by + 2.03 from another exact sequence in aggressiveness
> assay \#1 in a different treatment group

I wanted to know how this could be done. Standard tools (n-grams) only
detect duplicate sequences not duplicate sequences with an offset.

twopointzerothree develops a method for detecting duplicate offset
sequences.

It can be installed with

``` r
remotes::install_github("Sorbus-torminalis/twopointzerothree.git")
```
