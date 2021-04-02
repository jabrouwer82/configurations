interp.configureCompiler { compiler =>
  val s = compiler.settings
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
    + s.LintWarnings.Constant
    + s.LintWarnings.DelayedInitSelect
    + s.LintWarnings.DocDetached
    + s.LintWarnings.Inaccessible
    + s.LintWarnings.InferAny
    + s.LintWarnings.MissingInterpolator
    + s.LintWarnings.NullaryUnit
    + s.LintWarnings.OptionImplicit
    + s.LintWarnings.PackageObjectClasses
    + s.LintWarnings.PolyImplicitOverload
    + s.LintWarnings.PrivateShadow
    + s.LintWarnings.StarsAlign
    + s.LintWarnings.TypeParameterShadow
  )

  s.source.value match {
    case scala.tools.nsc.settings.SpecificScalaVersion(2, 12, _, _) =>
      s.processArgumentString("""
        -Ypartial-unification
        -Yno-adapted-args
        -Xlint:by-name-right-associative
        -Xlint:nullary-override
        -Xlint:unsound-match
      """)
    case scala.tools.nsc.settings.SpecificScalaVersion(2, 13, _, _) =>
      s.processArgumentString("-Ymacro-annotations")
  }
}

def logImplicits(value: Option[Boolean] = None) =
  interp.configureCompiler {
    c => c.settings.XlogImplicits.value = value.getOrElse(!c.settings.XlogImplicits.value)
  }
