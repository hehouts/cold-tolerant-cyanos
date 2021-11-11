# 🖼️ Big Picture


__


_note to reader (us): we completely changed our plan half way through this doc. will fix later_


Containment (i.e. (I think) jaccard containment) is for measuring what proportion of a little thing is also present in the big thing.

#### Containment
![](https://i.imgur.com/PMyNety.png =300x)
[source](https://www.biorxiv.org/content/10.1101/184150v1.full)

#### Jaccard similarity
![](https://i.imgur.com/glYUeHQ.png =300x200)
[source](https://medium.com/data-science-bootcamp/understand-jaccard-index-jaccard-similarity-in-minutes-25a703fbf9d7)

So an example of this is:
>“oh I see that germ A is present in my metagenomic sample. Is the whole known genome/pangenome of this organism present in this metagenomic sample? If so the containment will be 100%”

### Containment of CTG (~21) in Cyano genomes
There's [323 complete cyanogenomes in genbank] 
they are duplicates
(https://www.ncbi.nlm.nih.gov/datasets/genomes/?taxon=1117&utm_source=nuccore). 

*If we got 323 max containment values, what could we do with them? * 

- Many known CTG are housekeeping genes
- all cyanos have atleast one, probably many
- Cold shock proteins are not found in some thermal pool dwellers
- membrane fluidity   


### Questions:
- How does containment handle repeats in the genome?
    - Say genome A and genome B are identical with one exception: genome A has 2 copies of gene X, while B has only 1. will the containment of A in the genedatabase be higher?





- isolate the ctgs from the available genomes.
    - some wont have all, 
    - all will have some. 
- jaccard similarity of each ctg (21), for a heatmap of individuals



### Aim:
- compare the __gene-phylogeny of the cyanoCTgenes__ to the __organism-phyologeny of cyano genomes__
    - We can do this bc sourmash has been demonstrated to generate trees with accurate topology
        - potential concern: sourmash gets dicey over larger eveolutionary distances
            - BUT maybe it will be ok because... genes? are smaller? than whole genomes?
            - and the cyano genome phylogeny is known

![](https://i.imgur.com/ueGI3mE.png)

### To Do:
- find each of the CTGs in each of the cyanogenomes
    - We have the HMMs of the CTGs, 
    - 📊 Anvio: yes or no, on each CTG in each genome.
        - this gives us the heatmap dimension (or like included, non zero organisms) for each ctg
    -❓ **We need a gene sequence for each ctg in each genome** 
        - How do we do that? is it possible?
        - pick out the gene regions for each of the CTGs
- make k-mer signatures of each individual ctg, and *sourmash compare* each ctg among the genomes
- 🏆 Goal: See if the topology matches, and more importatntly for which genes does the topology appear to match?
    - if they all matched, that means the ctgs have evolved forever ago
