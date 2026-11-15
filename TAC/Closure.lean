import TAC.Basic

namespace TAC

/--
Reachability is defined inductively.

A state is reachable if it is:

1. The initial state; or
2. Reachable through a permitted transition
   from another reachable state.
-/
inductive Reachable
    {State : Type}
    (transition : Transition State)
    (initial : State) :
    State → Prop

  | start :
      Reachable transition initial initial

  | next
      {before after : State} :
      Reachable transition initial before →
      transition before after →
      Reachable transition initial after

/--
Invariant preservation over all reachable states.

Premises:

1. The invariant holds in the initial state.
2. Every permitted transition preserves it.

Conclusion:

The invariant holds in every reachable state.

The proof proceeds by induction over the
inductive reachability relation.
-/
theorem invariant_on_reachable
    {State : Type}
    (transition : Transition State)
    (initial : State)
    (property : State → Prop)
    (initialHolds : property initial)
    (preserves : Invariant property transition) :
    ∀ {state : State},
      Reachable transition initial state →
      property state := by

  intro state reachable

  induction reachable with

  | start =>
      exact initialHolds

  | @next before after previous permitted ih =>
      exact preserves permitted ih

end TAC
