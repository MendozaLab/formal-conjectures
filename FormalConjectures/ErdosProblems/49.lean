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
# Erdős Problem 49

*Reference:* [erdosproblems.com/49](https://www.erdosproblems.com/49)

Let `A = {a_1 < ... < a_t} ⊆ {1, ..., N}` be such that
`φ(a_1) < ... < φ(a_t)`. Erdős asked whether such sets can be larger than the
primes, and in particular whether `|A| = o(N)`.

Tao [Ta24d] solved this in the affirmative, proving the sharper bound
`|A| ≤ (1 + O((log log x)^5 / log x)) π(x)`.
-/

open Filter Asymptotics
open scoped Nat.Prime

namespace Erdos49

/-- A finite set has strictly increasing Euler totient values when read in the
natural order. -/
def TotientStrictMonoOn (A : Finset ℕ) : Prop :=
  ∀ ⦃a b : ℕ⦄, a ∈ A → b ∈ A → a < b → a.totient < b.totient

/-- The largest size of a subset of `{1, ..., N}` whose totient values are
strictly increasing in the natural order. -/
noncomputable def maxTotientStrictMonoCard (N : ℕ) : ℕ :=
  sSup {k : ℕ | ∃ A : Finset ℕ, A ⊆ Finset.Icc 1 N ∧ TotientStrictMonoOn A ∧ A.card = k}

/--
Erdős Problem 49. If `A = {a_1 < ... < a_t} ⊆ {1, ..., N}` and
`φ(a_1) < ... < φ(a_t)`, then the maximal possible `t` is `o(N)`.

This records Tao's affirmative resolution of the weaker question on the problem
page. -/
@[category research solved, AMS 11]
theorem erdos_49 :
    answer(True) ↔
      (fun N : ℕ => (maxTotientStrictMonoCard N : ℝ)) =o[atTop]
        (fun N : ℕ => (N : ℝ)) := by
  sorry

/--
Tao's sharper estimate: the maximal size is bounded by the prime-counting
function times `1 + O((log log N)^5 / log N)`.
-/
@[category research solved, AMS 11]
theorem erdos_49.variants.tao_prime_count_bound :
    ∃ C > (0 : ℝ), ∀ᶠ N in atTop,
      (maxTotientStrictMonoCard N : ℝ) ≤
        (1 + C * (Real.log (Real.log (N : ℝ))) ^ 5 / Real.log (N : ℝ)) * (π N : ℝ) := by
  sorry

end Erdos49
