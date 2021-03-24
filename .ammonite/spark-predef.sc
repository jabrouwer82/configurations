import $exec.`configure-compiler`

import $ivy.`org.apache.spark::spark-sql:2.4.0`
import $ivy.`sh.almond::ammonite-spark:0.10.0`

import org.apache.spark.sql._

val spark = {
  AmmoniteSparkSession.builder()
    .master("local[*]")
    .getOrCreate()
}

def sc = spark.sparkContext

println("""
Always run `AmmoniteSparkSession.sync()` after $ivy imports!
See https://github.com/alexarchambault/ammonite-spark for more details!
""")
