# SAMPLE_LST= ["dummy"]
FILENAMES ="file_names.txt"
# FILENAMES ="subset_file_names.txt"
SAMPLE_LST= [x.strip().split(".fna")[0] for x in open(FILENAMES, 'r')]

rule all:
    input:
        # reformat_fasta
        #     expand("{sample_i}.fa", sample_i=SAMPLE_LST),
        #         tsv is key file for contigs
        #     expand("{sample_i}.tsv", sample_i=SAMPLE_LST)
        #     expand("{sample_i}.db", sample_i=SAMPLE_LST)
        #     expand("{sample_i}.stats.txt", sample_i=SAMPLE_LST)
        expand("{sample_i}.hmm.sequence.txt", sample_i=SAMPLE_LST) 
    

rule reformat_fasta:
    input: 
        "cyano_wholegenomes/Cyano_complete_genomes/data/{sample_i}.fna"
    output:
        seq="{sample_i}.fa",
        rpt="{sample_i}.tsv"
    shell: 
        """
        anvi-script-reformat-fasta {input} -o {output.seq}\
        -l 0 --simplify-names --report-file {output.rpt}
        """

rule create_contigs_db:
    input:
        "{sample_i}.fa"
    output:
        "{sample_i}.db"
    threads: 4
    shell:
        """
        anvi-gen-contigs-database -f {input} -o {output}\
        -T {threads} --project-name ctg_cyanos
        """

rule run_hmms:
    input:
        "{sample_i}.db" 
    output:
        "{sample_i}.stats.txt"
    shell:
        """
        anvi-run-hmms -c {input} -H new_hmms/
        anvi-display-contigs-stats {input} --report-as-text -o {output}
        """

rule hmm_sequence_hits:
    input:
        db="{sample_i}.db",
        rpt="{sample_i}.stats.txt"
    output:
        "{sample_i}.hmm.sequence.txt"
    shell:
        """
        anvi-get-sequences-for-hmm-hits -c {input.db} --hmm-source new_hmms -o {output}
        """
