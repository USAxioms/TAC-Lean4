import TAC.Basic

namespace TAC

/--
If an invariant is preserved by every permitted
transition, then it holds after any particular
permitted transition, provided it held beforehand.
-/
theorem invariant_one_step
    {State : Type}
    {property : StateProperty State}
    {transition : Transition State}
    (preserves : Invariant property transition)
    {before after : State}
    (permitted : transition before after)
    (holdsBefore : property before) :
    property after := by
  exact preserves permitted holdsBefore

end TAC
