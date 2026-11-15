namespace TAC

/--
A transition relation describes which state changes
are permitted within a modeled system.
-/
abbrev Transition (State : Type) :=
  State → State → Prop

/--
A state property is a proposition evaluated
over a particular system state.
-/
abbrev StateProperty (State : Type) :=
  State → Prop

/--
An invariant is a state property preserved
by every permitted transition.

The property must hold before a transition
and remain true afterward.
-/
def Invariant
    {State : Type}
    (property : StateProperty State)
    (transition : Transition State) : Prop :=
  ∀ ⦃before after : State⦄,
    transition before after →
    property before →
    property after

/--
A minimal example system state containing
a natural-number value.
-/
structure SystemState where
  value : Nat
  deriving Repr, DecidableEq

end TAC
