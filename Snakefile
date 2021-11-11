# SAMPLE_LST= ["dummy"]
FILENAMES ="file_names.txt"
# FILENAMES ="subset_file_names.txt"
#SAMPLE_LST= [x.strip().split(".fna")[0] for x in open(FILENAMES, 'r')]
HMM_DIR_NAME="new_hmms"

FULL_SAMPLE_LST= [x.strip().split(".fna")[0] for x in open(FILENAMES, 'r')]
SAMPLE_LST= FULL_SAMPLE_LST[0:2]


rule all:
    input:
        # reformat_fasta
        #     expand("{sample_i}.fa", sample_i=SAMPLE_LST),
        #         tsv is key file for contigs
        #     expand("{sample_i}.tsv", sample_i=SAMPLE_LST)
        #     expand("{sample_i}.db", sample_i=SAMPLE_LST)
        #     expand("{sample_i}.stats.txt", sample_i=SAMPLE_LST)
        expand("outputs/hit_report/{sample_i}.hmm.sequence.txt", sample_i=SAMPLE_LST) 
    

rule reformat_fasta:
    input: 
        "data/cyano_wholegenomes/Cyano_complete_genomes/data/{sample_i}.fna"
    output:
        seq="data/formatted_seqs/{sample_i}.fa",
        rpt="outputs/reports/reformat_reports/{sample_i}.tsv"
    shell: 
        """
        anvi-script-reformat-fasta {input} -o {output.seq}\
        -l 0 --simplify-names --report-file {output.rpt}
        """

rule create_contigs_db:
    input:
        "data/formatted_seqs/{sample_i}.fa"
    output:
        "outputs/db/{sample_i}.db"
    threads: 4
    shell:
        """
        anvi-gen-contigs-database -f {input} -o {output}\
        -T {threads} --project-name ctg_cyanos
        """

#rule check_hmm_folder:
#    input: "/{HMM_DIR_NAME}/genes.hmm.gz"
#    output:
#    shell:
#        """
#        /new_hmms/genes.hmm.gz  /new_hmms/genes.txt 
#        """



rule run_hmms:
    input:
        "outputs/db/{sample_i}.db" 
    output:
        "outputs/reports/hmm_hits/{sample_i}.stats.txt"
    shell:
        """
        anvi-delete-hmms -c {input} --just-do-it
        anvi-run-hmms -c {input} --hmm-profile-dir {HMM_DIR_NAME}
        anvi-display-contigs-stats {input} --report-as-text -o {output}
        """

rule hmm_sequence_hits:
    input:
        db="outputs/db/{sample_i}.db",
        
        #we dont actually use these anymore, they are a placeholder for snakemake while .dbs are updated
        rpt="outputs/reports/hmm_hits/{sample_i}.stats.txt"
    output:
        "outputs/hit_report/{sample_i}.hmm.sequence.txt"
    shell:
        """
        anvi-get-sequences-for-hmm-hits -c {input.db} --hmm-source hmms -o {output}
        """
