/-
Copyright 2026 The Formal Conjectures Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-/

import FormalConjectures.Util.ProblemImports

/-!
# Erdős Problem 5

*Reference:* [erdosproblems.com/5](https://www.erdosproblems.com/5)
-/

open Filter Topology

namespace Erdos5

/-- A real number `C` is a subsequential limit of the normalized prime gaps
`(p_{n+1} - p_n) / log n`. -/
def NormalizedPrimeGapLimitPoint (C : ℝ) : Prop :=
  ∃ n : ℕ → ℕ, StrictMono n ∧
    Tendsto (fun i ↦ (primeGap (n i) : ℝ) / Real.log (n i)) atTop (𝓝 C)

/--
Erdős Problem 5. Let `C ≥ 0`. Is there an infinite sequence of indices `n_i`
such that
`(p_{n_i+1} - p_{n_i}) / log n_i → C`?
-/
@[category research open, AMS 11]
theorem erdos_5 : answer(sorry) ↔ ∀ C ≥ 0, NormalizedPrimeGapLimitPoint C := by
  sorry

end Erdos5
