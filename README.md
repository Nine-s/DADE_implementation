# hello nice persons who will have a look at this repo!

Here is a work in progress to implement the patterns described in my report.

Each pattern is implemented in a single file `main.nf`. There is one folder per pattern, named after it. Each one is associated with the Nextflow traces. It includes the DAG structure, a report with graph, a timeline and a table with the resources used by each process. For more details please see this link:

https://www.nextflow.io/docs/latest/tracing.html

To get the results of each process, go to the pattern you want to execute then run this command:

`nextflow run main.nf -with-report nextflow_report -with-trace nextflow_trace -with-timeline nextflow_timeline -with-dag nextflow_dag.html`

# TODO

- implement reuse pattern
- implement direct/sequential access
- echange data in stream between two processes (file exchange is by default with Nextflow)
- fix gather 

Note about fixing gather: I have not succeeded yet to implement gather correctly. A file is correctly written from different the gathered content fastq file. The problem is that it is not yet parlellized according to this definition of gather: *"A single file is written by multiple compute nodes where each node writes to a disjoint region of the file"* [Lauro Beltrão Costa et al, March 2014]