#!/usr/bin/env bash

Cache profilers
(open source)
- perf
- likwid
- linux (rdmsr/wrmsr)
- Linux Kernel (via/proc)
(proprietary)
- jClarity jMSR
- Intel VTune
- AMD Code Analyst
- Visual Studio 2012
- Oracl Studio

think about Prefetching,
 > organize data tso they can be pre-loaded to cache sequentially

 > Temporal Locality - repeatedly referring to same data in a short time span
 > Special Locality - Referring to data that is close together in memory
 > Sequential Locality - Referring to data that is arranged linearly in memory

General principles
 > Use smaller data types (-XX: +UseCompressedOops)
 > Avoid 'big holes' in your data
 > Make access as linear as possible

Data Layout Principles

> Primitive Collections (GNU Trove, GS-Coll)
> Arrays -> Linked Lists (prefer arrays)
> Hashtables -> Search Tree (prefer hashtables)
> Avoid Code bloating (Loop Unrolling) (use -O3 with causion, prefer -O2 optimization option for gcc)
> Custom Data Structures
    > Judy Arrays
        - an associative array/map
    > kD-Trees
        - generalised Binary Space Partitioning
    > Z-Order Curve
        - multidimentional data in one dimension

Adjust Page Size
> Common Size: 4KB, 2MB, 1GB
> Potential Speedup: 10%-30%
> -XX: +UseLargePages

False Sharing

Field Padding (project to start with on github, "Java Object Layout" Alexy Shipilov)

links:
- insightfullogic.com
- akkadia.org/drepper/cpumemory.pdf
- jclarity.com/friends/
- mechanical-sympathy.blogspot.co.uk
- g.oswego.edu/dl/concurency-interest/