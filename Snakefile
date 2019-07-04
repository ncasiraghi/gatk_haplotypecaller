configfile: "config.yaml"

#bam="/icgc/dkfzlsdf/analysis/B060/share/B060_Stuttgart_case/bam_files/WGS/blood/blood_XI046_ST_LFS_1_merged.mdup.bam",

SAMPLES = ['test_chr22']

rule all:
    input: expand("outs/calls/{sample}.vcf",sample=SAMPLES)

rule haplotype_caller:
    input:
        # single or list of bam files
        bam="/icgc/dkfzlsdf/analysis/B260/users/n790i/{sample}.bam",
        ref=config['reference']
        # known="dbsnp.vcf"  # optional
    output:
        gvcf="outs/calls/{sample}.g.vcf"
    log:
        "outs/logs/gatk/haplotypecaller/{sample}.log"
    params:
        extra="",  # optional
        java_opts="", # optional
    wrapper:
        "0.35.1/bio/gatk/haplotypecaller"

rule genotype_gvcfs:
    input:
        gvcf="outs/calls/{sample}.g.vcf",  # combined gvcf over multiple samples
        ref=config['reference']
    output:
        vcf="outs/calls/{sample}.vcf",
    log:
        "outs/logs/gatk/genotypegvcfs/{sample}.log"
    params:
        extra="",  # optional
        java_opts="", # optional
    wrapper:
        "0.35.1/bio/gatk/genotypegvcfs"