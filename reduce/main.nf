nextflow.enable.dsl=2

outdir = "results"

process COUNT_READS {
    publishDir outdir

    input:
        file L

    output:
        file "count_per_file.txt"
        file "count_total.txt"


    script:
        """
        grep -c "@" $L > count_per_file.txt
        cat $L | grep -c "@" > count_total.txt
        """
    //cat $L | grep -c "@" > count.txt
    //grep -c "@" $L > count.txt
    //find . -name "$L" | xargs grep "@" | wc -l > count.txt
}
//> count.txt
// https://stackoverflow.com/questions/13727917/use-wc-on-all-subdirectories-to-count-the-sum-of-lines
// if you want it on two or more different types of files u can put -o option
// find . -name '*.fileextension1' -o -name '*.fileextension2' | xargs wc -l


workflow {
        Channel.fromPath( '../data_gath/*.fastq' ).set{reads_ch}
        COUNT_READS ( reads_ch.collect() )
}

