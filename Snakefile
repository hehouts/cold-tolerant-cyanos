SAMPLE_LST= ["dummy", "dopey"]


rule all:
    input:
        # reformat_fasta
        #     expand("{sample_i}.fa", sample_i=SAMPLE_LST),
        #         tsv is key file for contigs
        #     expand("{sample_i}.tsv", sample_i=SAMPLE_LST)
        #     expand("{sample_i}.dup.db", sample_i=SAMPLE_LST)
        expand("{sample_i}.db", sample_i=SAMPLE_LST)

rule reformat_fasta:
    input: 
        "{sample_i}.fna"
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
        "{sample_i}.dup.db"
    threads: 4
    shell:
        """
        anvi-gen-contigs-database -f {input} -o {output}\
        -T {threads} --project-name ctg_cyanos
        """

rule run_hmms:
    input:
        "{sample_i}.dup.db" 
    output:
        "{sample_i}.db"
    shell:
        """
        cp {input} {output}
        anvi-run-hmms -c {output} -H new_hmms/
        """ 