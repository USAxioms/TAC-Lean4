import Lake
open Lake DSL

package tacLean4 where
  version := v"0.1.0"

lean_lib TAC

lean_exe tac where
  root := `Main
