```{r}

# After installing, comment that line out bc it doesnt need to be run over and over. In theory, just once. 
#install.packages("tidyverse")

library(tidyverse)

```

```{r}
# How to read in 1 file


r = read_delim("results/GCA_001704955.2_ASM170495v2_genomic.counts.txt", ">", col_names = F)%>%
  rename(freq=1, gene=2)

t = r %>% 
  rownames_to_column %>%
  gather(variable, value, -rowname) %>% 
  spread(rowname, value)
  
  
  
  pivot_longer


%>%
  as_factor(gene)%>%
  pivot_longer()


  column_to_rownames("gene")%>%

s = read_delim("results/GCA_001704955.2_ASM170495v2_genomic.counts.txt", ">", col_names = F)%>%
  pivot_longer(X2)
  #rename(freq=1, gene=2)%>%
 # column_to_rownames("gene")

t =  transpose(x)
  
```










y = read_delim("results/GCF_000007925.1_ASM792v1_genomic.counts.txt", ">", col_names = F, )%>%
  gather("X2")
  
  
  
  
  # rename(freq=1, gene=2)






