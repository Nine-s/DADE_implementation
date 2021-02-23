nextflow.enable.dsl=2

outdir = "results"

process P2 {
    publishDir outdir

    input:
        file L 

    output:
        file "concat.fq"

    script:
        """
        cat $L > concat.fq
        """
}

workflow{
    Channel.fromPath( '../data_gath/*.trimmed.fastq' ).set{reads_ch}
    P2( reads_ch.collect() )
}
