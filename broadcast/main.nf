nextflow.enable.dsl=2

outdir = "results"


process FASTQC {
    tag "fastqc $sample_id"
    publishDir outdir

    input:
    tuple val(sample_id), path(reads)

    output:
    path("*_fastqc.zip", emit: zip)

    script:
    """
    fastqc ${reads} 
    """
}


process FASTP {
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


workflow {
    read_pairs_ch  = channel.fromFilePairs( '../data/test_1.fastq', size: 1 )
    //read_pairs_ch = channel.fromFilePairs( params.reads, checkIfExists: true ) 
    FASTQC( read_pairs_ch )
    FASTP( read_pairs_ch )
    
}

