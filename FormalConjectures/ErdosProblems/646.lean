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
# Erdős Problem 646

*Reference:* [erdosproblems.com/646](https://www.erdosproblems.com/646)

Let `p₁, ..., pₖ` be distinct primes. Erdős asked whether there are infinitely
many `n` such that the exponent of each `pᵢ` in `n!` is even.

The answer is yes, proved by Berend [Be97], who further proved that the
sequence of such `n` has bounded gaps depending on the chosen primes.
-/

namespace Erdos646

/-- `n!` has even exponent at every prime in the finite set `P`. -/
def FactorialEvenAtPrimes (P : Finset ℕ) (n : ℕ) : Prop :=
  ∀ p ∈ P, p.Prime → Even (padicValNat p n.factorial)

/--
Erdős Problem 646. For every finite set of distinct primes, there are infinitely
many `n` such that `n!` has even exponent at each of those primes. -/
@[category research solved, AMS 11]
theorem erdos_646 :
    answer(True) ↔ ∀ P : Finset ℕ, (∀ p ∈ P, p.Prime) →
      {n : ℕ | FactorialEvenAtPrimes P n}.Infinite := by
  sorry

end Erdos646
