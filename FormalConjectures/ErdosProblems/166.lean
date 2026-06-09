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
import FormalConjectures.Wikipedia.RamseyNumbers

/-!
# Erdős Problem 166

*References:*
- [erdosproblems.com/166](https://www.erdosproblems.com/166)
- [Sp77] Spencer, Joel. Asymptotic lower bounds for Ramsey functions.
  Discrete Math. 20 (1977), 69--76.
- [AjKoSz80] Ajtai, Miklós; Komlós, János; Szemerédi, Endre. A note on Ramsey
  numbers. J. Combin. Theory Ser. A 29 (1980), 354--360.
- [MaVe23] Mattheus, Sam; Verstraete, Jacques. The asymptotics of $r(4,t)$.
  arXiv:2306.04007 (2023).

### AI disclosure

Lean 4 code in this file was drafted with assistance from OpenAI Codex and
Claude (Anthropic). The mathematical content and references are the author's
own work.
-/

open Filter Real

namespace Erdos166

/--
Erdős asked for a lower bound of the form
$R(4,k) \gg k^3 / (\log k)^{O(1)}$.
-/
@[category research solved, AMS 5]
theorem erdos_166 :
    ∃ C > (0 : ℝ), (fun k ↦ (RamseyNumbers.graphRamseyNumber 4 k : ℝ)) ≫
      (fun k ↦ (k : ℝ) ^ 3 / (log k) ^ C) := by
  sorry

/--
Mattheus and Verstraete proved the explicit lower bound
$R(4,k) \gg k^3 / (\log k)^4$.
-/
@[category research solved, AMS 5]
theorem erdos_166.variants.mattheus_verstraete :
    (fun k ↦ (RamseyNumbers.graphRamseyNumber 4 k : ℝ)) ≫
      (fun k ↦ (k : ℝ) ^ 3 / (log k) ^ (4 : ℝ)) := by
  sorry

/--
The Mattheus-Verstraete bound implies Erdős's requested lower bound with an
`O(1)` logarithmic exponent.
-/
@[category test, AMS 5]
theorem erdos_166.variants.mattheus_verstraete_implies_problem
    (h : type_of% erdos_166.variants.mattheus_verstraete) : type_of% erdos_166 := by
  exact ⟨4, by norm_num, h⟩

end Erdos166
