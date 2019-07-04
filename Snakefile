import os

configfile: "config.yaml"

SAMPLES = []
for bamfile in config['bam_samples']:
    SAMPLES.append(os.path.splitext(os.path.basename(bamfile))[0])
print(SAMPLES)

rule all:
    input: expand("outs/calls/{sample}.vcf",sample=SAMPLES)

rule haplotype_caller:
    input:
        # single or list of bam files
        bam="/icgc/dkfzlsdf/analysis/B060/share/B060_Stuttgart_case/bam_files/WGS/blood/{sample}.bam",
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