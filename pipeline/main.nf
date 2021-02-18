nextflow.enable.dsl=2

outdir = "results"


process FASTP_1 {
    tag 'fastp'
    publishDir outdir

    input:
    tuple val(name), path(reads)

    output:
    tuple val(name), path("${name}*.trimmed.fastq"), emit: sample_trimmed

    script:
    """
    fastp -i ${reads} -o ${name}.trimmed.fastq 
    """
}


process FASTP_2 {
    tag 'fastp'
    publishDir outdir

    input:
    tuple val(name), path(reads)

    output:
    tuple val(name), path("${name}*.F2.trimmed.fastq"), emit: sample_trimmed

    script:
    """
    fastp -i ${reads} -o ${name}.F2.trimmed.fastq 
    """
}


workflow {
    read_pairs_ch  = channel.fromFilePairs( '../data/test_1.fastq', size: 1 )
    FASTP_1( read_pairs_ch )
    FASTP_2( FASTP_1.output )
    
}

