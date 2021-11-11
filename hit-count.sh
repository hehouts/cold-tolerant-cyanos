


# note - internal genomes - > 
# note - can use "internal genomes" or "external genomes" - 


    # Internal genomes:
    # "An internal genome is any bin described in an anvi’o collection stored in an anvi’o profile-db."
    # Internal genomes look like: 
    #                name   |     bin_id |	collection_id|	profile_db_path	contigs_db_path
    #                Name_01|	Bin_id_01|	Collection_A |	/path/to/profile.db	/path/to/contigs.db


    # External genomes:
    # "An external genome is any genome assembly that was converted into a contigs-db
    # from its original FASTA file format using the program anvi-gen-contigs-database."
    # External genomes looks like:
    #                name	|  contigs_db_path
    #               Name_01	|  /path/to/contigs-01.db
    #               Name_02	|  /path/to/contigs-02.db  


    # I'm pretty sure we're working with external genomes


    # To run "anvi-script-gen-hmm-hits-matrix-across-genomes":
    # anvi-script-gen-hmm-hits-matrix-across-genomes -i internal-genomes \
    #                                           --hmm-source Bacteria_71 \
    #                                           -o output.txt

    anvi-script-gen-hmm-hits-matrix-across-genomes -e external-genomes.tsv --hmm-source hmms -o gene_hit_matrix_output.txt

    # our "external genomes" is stored in a tsv, external-genomes.tsv. external-genomes.txt is... wrong looking! 
    #         external-genomes-path-2.tsv looks usable for this too

    # other option, but I dont think this fits our hmm/ goals/choices
    # anvi-script-gen-hmm-hits-matrix-across-genomes -e external-genomes \
    #                                               --list-hmm-sources




## getting this warning :

# WARNING
# ===============================================
# You (or the programmer) requested genome descriptions for your internal and/or
# external genomes to be loaded _without_ a 'full init'. There is nothing for you
# to be concerned. This is just a friendly reminder to make sure you know that if
# something goes terribly wrong later (like your computer sets itself on fire),
# this may be the reason.