cat cyano_UID.txt | while read file
do
wget https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nuccore&id=${file}&rettype=fasta&retmode=text&api_key=1be37c519ed1bad92947736743f39695060:wq8
done
