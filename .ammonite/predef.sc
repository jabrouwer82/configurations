interp.configureCompiler { compiler =>
  val s = compiler.settings
  s.YpartialUnification.value = true
  s.deprecation.value = true
  s.explaintypes.value = true
  // s.fatalWarnings.value = true
  s.feature.value = true
  s.future.value = true
  s.nowarnings.value = false
  s.unchecked.value = true
  s.warnDeadCode.value = true
  s.warnNumericWiden.value = true
  s.warnValueDiscard.value = true
  s.warnExtraImplicit.value = true
  s.noAdaptedArgs.value = true
  // s.warnNullaryOverride = true
  // s.warnNullaryUnit = true
  // s.warnInferAny = true
  // s.warnInaccessible.value = true
  s.language.value ++ (
    s.languageFeatures.macros
    + s.languageFeatures.higherKinds
    + s.languageFeatures.existentials
    + s.languageFeatures.implicitConversions
  )
  s.lint.value ++ (
    s.LintWarnings.AdaptedArgs
    + s.LintWarnings.ByNameRightAssociative
    + s.LintWarnings.Constant
    + s.LintWarnings.DelayedInitSelect
    + s.LintWarnings.DocDetached
    + s.LintWarnings.Inaccessible
    + s.LintWarnings.InferAny
    + s.LintWarnings.MissingInterpolator
    + s.LintWarnings.NullaryOverride
    + s.LintWarnings.NullaryUnit
    + s.LintWarnings.OptionImplicit
    + s.LintWarnings.PackageObjectClasses
    + s.LintWarnings.PolyImplicitOverload
    + s.LintWarnings.PrivateShadow
    + s.LintWarnings.StarsAlign
    + s.LintWarnings.TypeParameterShadow
    + s.LintWarnings.UnsoundMatch
  )
}

def logImplicits(value: Option[Boolean] = None) =
  interp.configureCompiler {
    c => c.settings.XlogImplicits.value = value.getOrElse(!c.settings.XlogImplicits.value)
  }

import $file.`sparkcognition`

sparkcognition.addSparkRepo()

import $ivy.`org.typelevel::simulacrum:1.0.0`
import $ivy.`com.sparkcognition::data-ingestion-lib:latest.integration`
// import $ivy.`com.sksamuel.pulsar4s::pulsar4s-circe:2.4.6`
// import $ivy.`com.sksamuel.pulsar4s::pulsar4s-core:2.4.6`
// import $ivy.`io.circe::circe-core:0.13.0`
// import $ivy.`io.circe::circe-generic:0.13.0`
// import $ivy.`io.circe::circe-parser:0.13.0`
// import $ivy.`org.typelevel::mouse::0.24`

import $plugin.$ivy.`org.typelevel:::kind-projector:0.11.0`
import $plugin.$ivy.`com.olegpy::better-monadic-for:0.3.1`
import $plugin.$ivy.`org.scalamacros:::paradise:2.1.0`

object Imports {
  import language.experimental.macros
  import reflect.macros.blackbox.Context
  import scala.annotation.StaticAnnotation
  import scala.annotation.compileTimeOnly

  @compileTimeOnly("This should just always say 'compile time only annotation', why do I have to write this myself")
  class fpimports extends StaticAnnotation {
    def macroTransform(annottees: Any*): Any = macro fpimports.impl
  }

  object fpimports {
    def impl(c: Context)(annottees: c.Expr[Any]*): c.Expr[Any] = {
      import c.universe._
      c.Expr(q"""
        import cats._
        import cats.data._
        import cats.implicits._
        import cats.effect._
        import cats.effect.implicits._
        import cats.effect.concurrent._
        import simulacrum._
        import scala.language.higherKinds
        import scala.language.implicitConversions
        ()
      """)
    }
  }

  @compileTimeOnly("This should just always say 'compile time only annotation', why do I have to write this myself")
  class futureimports extends StaticAnnotation {
    def macroTransform(annottees: Any*): Any = macro futureimports.impl
  }

  object futureimports {
    def impl(c: Context)(annottees: c.Expr[Any]*): c.Expr[Any] = {
      import c.universe._
      c.Expr(q"""
        import scala.util.{Success, Failure}
        import scala.concurrent._
        import scala.util.control.NonFatal
        import scala.util._
        implicit val ec = ExecutionContext.global
        ()
      """)
    }
  }
}

import Imports._
