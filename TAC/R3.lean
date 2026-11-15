namespace TAC

/--
Bounded Russell Recursive Refinement.

The fuel parameter limits the maximum number
of refinement operations.

Zero fuel returns the current state.

Each additional unit of fuel permits
one additional refinement operation.
-/
def boundedRefine
    {State : Type}
    (refine : State → State) :
    Nat → State → State
  | 0, state => state
  | fuel + 1, state =>
      boundedRefine refine fuel (refine state)

/--
Bounded refinement preservation theorem.

If every individual refinement operation
preserves a declared property, then every
finite bounded refinement sequence also
preserves that property.

This theorem establishes preservation,
not convergence or optimality.
-/
theorem boundedRefine_preserves
    {State : Type}
    (refine : State → State)
    (property : State → Prop)
    (preserves :
      ∀ state,
        property state →
        property (refine state)) :
    ∀ fuel state,
      property state →
      property (boundedRefine refine fuel state) := by
  intro fuel
  induction fuel with
  | zero =>
      intro state holds
      simpa [boundedRefine] using holds
  | succ fuel ih =>
      intro state holds
      simpa [boundedRefine] using
        ih (refine state) (preserves state holds)

end TAC
