type ColorStop = (P:Point, C:Color)

ProjectLinearGradient (A:Point, B:Point) : Point >> Real
    v   = B - A
    Δs  = v / (v ∙ v)
    s00 = A ∙ Δs
    ∀ P
        >> P ∙ Δs - s00

ProjectRadialGradient (A:Point, r:Real) : Point >> Real
    ∀ P
        >> ‖(P - A)‖ / r

PadGradient () : GradientExtender
    ∀ s
        >> 0 ▷ s ◁ 1

RepeatGradient () : GradientExtender
    ∀ s
        >> s - ⌊s⌋

ReflectGradient () : GradientExtender
    ∀ s
        >> |(|(s - 1)| % 2 - 1)|

GradientSpan (A:Color, B:Color) : Real >> Color
    ∀ s
        >> sA + (1 - s)B

ApplyLinearGradient (A:ColorStop, B:ColorStop) : Point >> Color
    → ProjectLinearGradient (A.P, B.P) → PadGradient () → GradientSpan (A.C, B.C)
