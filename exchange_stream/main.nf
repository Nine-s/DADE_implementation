nextflow.enable.dsl=2

process foo {
  input: val data
  output: val result
  exec:
    result = "$data world"
}

process bar {
    input: val data
    output: val result
    exec:
      result = data.toUpperCase()
}

workflow {
   //channel.from('Hello') | map { it.reverse() } | (foo & bar) | mix | view
   channel.from('Hello').set{hello_ch}
   foo(hello_ch)
   bar(foo.output)
   bar.output.view()

}

