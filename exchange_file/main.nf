nextflow.enable.dsl=2

outdir = "results"


process FASTP_1 {
    tag 'fastp'
    publishDir outdir

    input:
    tuple val(name), path(reads)

    output:
    tuple val(name), path("trimmed.fastq")

    script:
    """
    fastp -i ${reads} -o trimmed.fastq 
    """
}


process FASTP_2 {
    tag 'fastp'
    publishDir outdir

    input:
    tuple val(name), path(reads)

    output:
    tuple val(name), path("trimmed_2.fastq")

    script:
    """
    fastp -i ${reads} -o trimmed_2.fastq 
    """
}


workflow {
    read_pairs_ch  = channel.fromFilePairs( '../data/test_1.fastq', size: 1 )
    FASTP_1( read_pairs_ch )
    FASTP_2( FASTP_1.output )
    
}

