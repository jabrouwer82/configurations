interp.configureCompiler { compiler =>
  val s = compiler.settings
  s.YpartialUnification.value = true
  s.deprecation.value = true
  s.explaintypes.value = true
  s.Ydelambdafy.tryToSetColon(List("inline"))
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

import $ivy.`org.typelevel::simulacrum:latest.release`
import $ivy.`io.circe::circe-core:latest.release`
import $ivy.`io.circe::circe-generic:latest.release`
import $ivy.`io.circe::circe-parser:latest.release`
import $ivy.`org.typelevel::mouse:latest.release`
import $ivy.`org.typelevel::cats:latest.release`
import $ivy.`org.typelevel::cats-effect:latest.release`
import $ivy.`org.typelevel::cats-effect:latest.release`

import $plugin.$ivy.`org.typelevel:::kind-projector:latest.release`
import $plugin.$ivy.`com.olegpy::better-monadic-for:latest.release`
import $plugin.$ivy.`org.scalamacros:::paradise:latest.release`

// Stuff I just always want in scope:
import scala.util._
import scala.concurrent._
import java.util.UUID
import scala.util.control.NonFatal

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
        ()
      """)
    }
  }
}

import Imports._
