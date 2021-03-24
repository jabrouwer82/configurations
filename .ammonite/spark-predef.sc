import $exec.`configure-compiler`

//import $ivy.`org.apache.spark::spark-sql:2.4.0`
import ammonite.ops._
interp.load.cp(ls! root/"usr"/"local"/"anaconda3"/"envs"/"dbconnect"/"lib"/"python3.7"/"site-packages"/"pyspark"/"jars")

@


import $ivy.`sh.almond::ammonite-spark:0.10.0`

import org.apache.spark.sql._

val spark = {
  AmmoniteSparkSession.builder()
    .master("local[*]")
    .getOrCreate()
}

def sc = spark.sparkContext

// Running ammonite in class based mode causes a bunch of junk to get imported
// from objects that then cause annoying "permanently hidden by" warnings.
import spark.implicits.{
  eq => _,
  synchronized => _,
  ne => _,
  wait => _,
  asInstanceOf => _,
  ## => _,
  == => _,
  hashCode => _,
  notify => _,
  isInstanceOf => _,
  != => _,
  notifyAll => _,
  equals => _,
  getClass => _,
  _
}
import scala.collection.JavaConverters.{
  eq => _,
  synchronized => _,
  ne => _,
  wait => _,
  asInstanceOf => _,
  ## => _,
  == => _,
  hashCode => _,
  notify => _,
  isInstanceOf => _,
  != => _,
  notifyAll => _,
  equals => _,
  getClass => _,
  _
}

import org.apache.spark.sql._
import org.apache.spark.sql.types._

println("""
Always run `AmmoniteSparkSession.sync()` after $ivy imports!
For more details, see:
https://github.com/alexarchambault/ammonite-spark
""")
