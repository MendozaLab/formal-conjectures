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
# Erdős Problem 53

*Reference:* [erdosproblems.com/53](https://www.erdosproblems.com/53)

Let `A` be a finite set of integers. Erdős asked whether, for every `k`, if
`|A|` is sufficiently large depending on `k`, then there are at least `|A|^k`
integers which are either the sum or the product of distinct elements of `A`.

Asked by Erdős and Szemerédi [ErSz83]. Solved in this form by Chang [Ch03].
-/

namespace Erdos53

/-- Sums of subsets of `A`, i.e. sums of distinct elements of `A`. -/
def subsetSums (A : Finset ℤ) : Finset ℤ :=
  A.powerset.image fun B => B.sum id

/-- Products of subsets of `A`, i.e. products of distinct elements of `A`. -/
def subsetProducts (A : Finset ℤ) : Finset ℤ :=
  A.powerset.image fun B => B.prod id

/-- Integers represented as either a subset sum or a subset product of `A`. -/
def sumOrProductValues (A : Finset ℤ) : Finset ℤ :=
  subsetSums A ∪ subsetProducts A

/--
Erdős Problem 53. For every `k`, sufficiently large finite integer sets `A`
have at least `|A|^k` integers representable as either a sum or a product of
distinct elements of `A`. -/
@[category research solved, AMS 11]
theorem erdos_53 :
    answer(True) ↔ ∀ k : ℕ, ∃ N : ℕ, ∀ A : Finset ℤ,
      N ≤ A.card → A.card ^ k ≤ (sumOrProductValues A).card := by
  sorry

end Erdos53
