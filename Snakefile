rule haplotype_caller:
    input:
        # single or list of bam files
        bam="/icgc/dkfzlsdf/analysis/B060/share/B060_Stuttgart_case/bam_files/WGS/blood/blood_XI046_ST_LFS_1_merged.mdup.bam",
        ref="/icgc/dkfzlsdf/analysis/B260/resource/human/hg19/hg19_no_chr.fa"
        # known="dbsnp.vcf"  # optional
    output:
        gvcf="/icgc/dkfzlsdf/analysis/B260/projects/chromothripsis_medulloblastoma/wgs/gatk_haplotypecaller_calls/calls/blood_XI046_ST_LFS_1_merged.mdup.g.vcf"
    log:
        "/icgc/dkfzlsdf/analysis/B260/projects/chromothripsis_medulloblastoma/wgs/gatk_haplotypecaller_calls/logs/gatk/haplotypecaller/blood_XI046_ST_LFS_1_merged.mdup.log"
    params:
        extra="",  # optional
        java_opts="", # optional
    wrapper:
        "0.35.1/bio/gatk/haplotypecaller"
