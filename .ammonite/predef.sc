import $exec.`configure-compiler`

// Fs2 and cats-effect have ce3 as the latest release artifacts, so their versions have to be hard coded.

import $ivy.`co.fs2::fs2-core:2.4.4`
import $ivy.`com.chuusai::shapeless:latest.release`
import $ivy.`io.chrisdavenport::cats-time:latest.release`
import $ivy.`io.circe::circe-generic:latest.release`
import $ivy.`io.circe::circe-parser:latest.release`
import $ivy.`org.typelevel::alleycats-core:latest.release`
import $ivy.`org.typelevel::cats-collections-core:latest.release`
import $ivy.`org.typelevel::cats-core:latest.release`
import $ivy.`org.typelevel::cats-effect:2.2.0`
import $ivy.`org.typelevel::kittens:latest.release`
import $ivy.`org.typelevel::mouse:latest.release`
import $ivy.`org.typelevel::simulacrum:latest.release`
import $ivy.`com.github.julien-truffaut::monocle-core:latest.release`
import $ivy.`com.github.julien-truffaut::monocle-macro:latest.release`
import $ivy.`eu.timepit::refined:latest.release`
import $ivy.`com.github.pureconfig::pureconfig:latest.release`

// Spark stuff
// import $ivy.`org.apache.spark::spark-sql:2.4.0`
// import $ivy.`org.typelevel::frameless-cats:0.8.0`
// import $ivy.`org.typelevel::frameless-dataset:0.8.0`
// import $ivy.`sh.almond::ammonite-spark:0.3.0`

// HTTP stuff
// import $ivy.`com.softwaremill.sttp.tapir::tapir-core:latest.release`
// import $ivy.`org.http4s::http4s-core:latest.release`
// Tapir requires a bunch of other imports, I'll add them as I find them.

// Fancy FP stuff
// import $ivy.`org.typelevel::cats-free:latest.release`
// import $ivy.`org.typelevel::cats-mtl:latest.release`
// import $ivy.`org.typelevel::cats-tagless:latest.release`

// Database stuff
// import $ivy.`com.oracle.database.jdbc:ojdbc8:18.3.0.0`
// import $ivy.`org.tpolecat::doobie-core:latest.release`
// import $ivy.`org.tpolecat::doobie-h2:latest.release`
// import $ivy.`org.tpolecat::doobie-quill:latest.release`

// Alternative IOs
// import $ivy.`dev.zio" %% "zio:latest.release`
// import $ivy.`io.monix::monix:3.3.0`

// Numbers and number-like things
// import $ivy.`org.typelevel::algebra:latest.release`
// import $ivy.`org.typelevel::spire:latest.release`
// import $ivy.`org.typelevel::squants:latest.release`

import $plugin.$ivy.`org.typelevel:::kind-projector:latest.release`
import $plugin.$ivy.`com.olegpy::better-monadic-for:latest.release`

import cats._
import cats.data._
import cats.effect._
import cats.effect.concurrent._
import cats.effect.implicits._
import cats.implicits._
import java.time._
import java.util.UUID
import java.util.concurrent.Executors
import scala.concurrent._
import scala.language.higherKinds
import scala.util._
import scala.util.control.NonFatal
import shapeless._
import shapeless.syntax._
import simulacrum._

import java.util.concurrent.Executors
import scala.concurrent.ExecutionContext
import cats.effect.IO
// Inspired by djspiewak's gist: https://gist.github.com/djspiewak/46b543800958cf61af6efa8e072bfd5c
// Use this instead of the global context.
implicit val cpuEc = ExecutionContext.fromExecutor(Executors.newFixedThreadPool(Runtime.getRuntime.availableProcessors))
implicit val cpuCs = IO.contextShift(cpuEc)
// Cats-effect's Blocker is more likely to be useful than this, but this is simple to set up.
val blockingEc = ExecutionContext.fromExecutor(Executors.newCachedThreadPool)
val blockingCs = IO.contextShift(blockingEc)
// This is unlikely to be used in repl, it's more of a POC for an Async IO EC.
val dispatchEc = ExecutionContext.fromExecutor(Executors.newFixedThreadPool(4))
val dispatchCs = IO.contextShift(dispatchEc)


// import $plugin.$ivy.`org.scalamacros:::paradise:latest.release`
// object Imports {
//   import language.experimental.macros
//   import reflect.macros.blackbox.Context
//   import scala.annotation.StaticAnnotation
//   import scala.annotation.compileTimeOnly

//   @compileTimeOnly("This should just always say 'compile time only annotation', why do I have to write this myself.")
//   class fpimports extends StaticAnnotation {
//     def macroTransform(annottees: Any*): Any = macro fpimports.impl
//   }

//   object fpimports {
//     def impl(c: Context)(annottees: c.Expr[Any]*): c.Expr[Any] = {
//       import c.universe._
//       c.Expr(q"""
//         import cats._
//         import cats.data._
//         import cats.implicits._
//         import cats.effect._
//         import cats.effect.implicits._
//         import cats.effect.concurrent._
//         import simulacrum._
//         import scala.language.higherKinds
//         ()
//       """)
//     }
//   }
// }

// import Imports._
