nextflow.enable.dsl=2

params.num_regions = 10
params.suffix_length = 5
outdir = "results"

process split_fastq {
    publishDir outdir

    input:
    tuple val(name), path(fastq)

    output:
    tuple val(name), path("${name}_*")

    shell:
    """
    split ${fastq} -a ${params.suffix_length} -d -l ${params.num_regions} test_1_
    """
}


    // '''
    // cat "!{fastq}" | split \\
    //     -a "!{params.suffix_length}" \\
    //     -d \\
    //     -l "!{params.num_regions}" \\
    //     --filter='gzip > ${FILE}.fastq' \\
    //     - \\
    //     "!{name}-"
    // '''

process fastp {
    publishDir outdir

    input:
    tuple val(name), path(fastq)

    output:
    tuple val(name), path("${fastq.getBaseName(2)}.trimmed.fastq")

    """
    fastp -i "${fastq}" -o "${fastq.getBaseName(2)}.trimmed.fastq"
    """
}

workflow {

    Channel.fromFilePairs( '../data/test_1.fastq', size: 1 ) \
        | split_fastq \
        | map { name, fastq -> tuple( groupKey(name, fastq.size()), fastq ) } \
        | transpose() \
        | fastp \
        | groupTuple() \
        | map { key, fastqs -> tuple( key.toString(), fastqs ) } \
        | view()
}