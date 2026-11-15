namespace TAC

/--
A verification gate evaluates a system state
and returns a Boolean decision.
-/
abbrev VerificationGate (State : Type) :=
  State → Bool

/--
A gate is sound for a property when every
state accepted by the gate satisfies
that declared property.
-/
def GateSound
    {State : Type}
    (gate : VerificationGate State)
    (property : State → Prop) : Prop :=
  ∀ state,
    gate state = true →
    property state

/--
An accepted state satisfies the declared
property, provided gate soundness has
been established.
-/
theorem accepted_state_satisfies_property
    {State : Type}
    (gate : VerificationGate State)
    (property : State → Prop)
    (sound : GateSound gate property)
    (state : State)
    (accepted : gate state = true) :
    property state := by
  exact sound state accepted

end TAC
