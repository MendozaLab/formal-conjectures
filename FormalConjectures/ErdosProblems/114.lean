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
# Erdős Problem 114

*Reference:* [erdosproblems.com/114](https://www.erdosproblems.com/114)

The **Erdős–Herzog–Piranian (EHP) conjecture** (1958): among all monic polynomials
$p$ of degree $n$, the arc length of the lemniscate $\{z \in \mathbb{C} \mid |p(z)| = 1\}$
is maximised uniquely by $p(z) = z^n - c$, $|c| = 1$.

### Known partial results

- **$n = 1$**: immediate, since a monic linear polynomial has a translated
  unit circle as its unit lemniscate.
- **$n = 2$**: MacLane (1953/54) [Ma53], with an accessible source pin in
  Eremenko–Hayman (1999) [EH99, abstract and Lemma 5 remark]
- **$3 \leq n \leq 14$**: Mendoza (2026), IEEE 1788-rigorous interval arithmetic,
  [doi:10.5281/zenodo.19480329](https://doi.org/10.5281/zenodo.19480329)
- **Sufficiently large $n$**: Tao (2025) [Ta25]
- **Upper bound**: $L(p) \leq 2\pi n$ for all monic degree-$n$ $p$ (Pommerenke, 1961)

### References

- [EHP58] Erdős, P., Herzog, F., Piranian, G. (1958). *Metric properties of polynomials*.
  J. Analyse Math. 6, 125–148.
- [Po61] Pommerenke, Ch. (1961). *Über die Kapazität ebener Kontinuen*.
  Math. Ann. 144, 115–120.
- [Ma53] MacLane, G. R. (1953/54). *On a conjecture of Erdős, Herzog,
  and Piranian*. Michigan Math. J. 2, 147–148. doi:10.1307/mmj/1028989918.
- [EH99] Eremenko, A., Hayman, W. (1999). *On the length of lemniscates*.
  Michigan Math. J. 46, 409–415; arXiv:0805.2295.  The abstract states the
  degree-two extremal case, and the proof remark after Lemma 5 identifies
  `z^2 + 1` as extremal for `d = 2`, which is length-equivalent to `z^2 - 1`
  by rotation.
- [Ta25] Tao, T. (2025). *The Erdős–Herzog–Piranian conjecture for large $n$*.

### AI/tooling disclosure

Lean 4 code and draft wording in this file were prepared with AI-assisted
tooling. The mathematical claim rests only on the cited literature rows and
SHA-checked certificate artifacts; no AI output is used as proof evidence. The
author takes responsibility for the mathematical claims, certificate selection,
and submission wording. The mathematical content, computational verification,
and certificates are the author's own work.
-/

open Polynomial MeasureTheory ENNReal Classical

namespace Erdos114

/-- The level curve (lemniscate) of a polynomial `p` at level 1:
$\{z \in \mathbb{C} \mid \|p(z)\| = 1\}$. -/
def levelCurveUnit (p : ℂ[X]) : Set ℂ :=
  {z : ℂ | ‖p.eval z‖ = 1}

/-- The arc length of the lemniscate of `p`, measured as the
1-dimensional Hausdorff measure of the level curve. -/
noncomputable def arcLength (p : ℂ[X]) : ℝ≥0∞ :=
  μH[1] (levelCurveUnit p)

/-- **Erdős Problem 114** (open conjecture). Among all monic polynomials of
degree $n$, $p(z) = z^n - c$ (with $|c| = 1$) maximises the arc length of the
lemniscate $\{z \in \mathbb{C} \mid |p(z)| = 1\}$.

Originally posed by Erdős, Herzog, and Piranian [EHP58]. Known for $n = 1$ by
the direct linear case, for $n = 2$ by MacLane [Ma53] / Eremenko–Hayman [EH99],
for $3 \leq n \leq 14$ by Mendoza (2026), and for sufficiently large $n$ by Tao
[Ta25]. This file does not bridge Tao's implicit large-`n` threshold and does
not close the all-degree conjecture. -/
@[category research open, AMS 30]
theorem erdos_114 (n : ℕ) (hn : 1 ≤ n)
    (p : ℂ[X]) (hp : p.Monic) (hp_deg : p.natDegree = n) :
    arcLength p ≤ arcLength (X ^ n - C 1) := by
  sorry

/- ### Endpoint certificate rows (n = 1, 2)

The first row is the direct analytic linear case.  The second row is the
degree-two literature theorem, historically MacLane [Ma53] and pinned here to
the accessible Eremenko--Hayman source: *On the length of lemniscates*,
Michigan Math. J. 46 (1999), 409--415; arXiv:0805.2295, abstract and Lemma 5
remark.  They are kept as explicit external dependencies, parallel to the
interval-certificate axioms below. -/

/-- Direct linear case: a monic linear polynomial has a translated unit-circle
unit lemniscate, so it has the same length as `z - 1`. -/
axiom ehp_cert_1_direct (p : ℂ[X]) (hp : p.Monic) (hd : p.natDegree = 1) :
    arcLength p ≤ arcLength (X ^ 1 - C 1)

/-- Eremenko--Hayman degree-two theorem for the EHP lemniscate problem. -/
axiom ehp_cert_2_eremenko_hayman
    (p : ℂ[X]) (hp : p.Monic) (hd : p.natDegree = 2) :
    arcLength p ≤ arcLength (X ^ 2 - C 1)

/- ### Computational certificates (IEEE 1788, n = 3 … 14)

Each axiom encodes one external branch-and-bound interval certificate.  The
Lean proof below is intentionally transparent: the universal theorem quantifies
over all monic complex polynomials of the stated degree, while the hard analytic
and computational content is not hidden inside helper lemmas; it is represented
by the explicit certificate axioms listed here.

Public certificate record:
`https://doi.org/10.5281/zenodo.19480329`

Public result directory:
`https://github.com/MendozaLab/erdos-experiments/tree/main/results/erdos-114`

Row-level certificate hashes:

| n | result file | SHA-256 |
|---|---|---|
| 3 | EXP-MM-EHP-007-n3-inari_RESULTS.json | a884d1bfec1563f6e6f7ae4cbb2ec607b43be033d06c41d14782459e67ec2b95 |
| 4 | EXP-MM-EHP-007-n4-inari_RESULTS.json | 0924dd7424d2615099ff95d47cb4c120ba22e907adaa9af881cded9678241209 |
| 5 | EXP-MM-EHP-007-n5-inari_RESULTS.json | 21ca3c7607dc1fbb7b08982666f4620dff808fdc581eecae9967c51fafb05447 |
| 6 | EXP-MM-EHP-007-n6-inari_RESULTS.json | 41ac3027e9ae5add9e1208c0faa5897c36762d69b5eeccef96068c96af567b3d |
| 7 | EXP-MM-EHP-007-n7-inari_RESULTS.json | 832ddaf219d717e275ee95c01f271dd3120e255cf81f3aa72ba3c2f56ff84054 |
| 8 | EXP-MM-EHP-007-n8-inari_RESULTS.json | c7a1fd80fbfed1efd53eaa35283e467994e3a4175541f3817485d9551d14dcdc |
| 9 | EXP-MM-EHP-007-n9-inari_RESULTS.json | 5bc2887826c9ef21752c115c9a4a2ab983f94eea06f0111ea98db454fe1358f4 |
| 10 | EXP-MM-EHP-007-n10-inari_RESULTS.json | 2b72e052aa7200f7ac5d40992843601988de234093c44860fde99a7871e19581 |
| 11 | EXP-MM-EHP-007-n11-inari_RESULTS.json | 67f20cce1d3d54cad2d6bc708ab9ec796c17cb4d34a9728f2954b8a6cbf7c89c |
| 12 | EXP-MM-EHP-007-n12-inari_RESULTS.json | 42a517997445d158649feefae2b7287bc9b548c6391796df0c1246489c6aa064 |
| 13 | EXP-MM-EHP-007-n13-inari_RESULTS.json | a4e72a9be2811e9d2290c6cdd0f6a9f1dd17fa85790e380bd5af8b09179e02ac |
| 14 | EXP-MM-EHP-007-n14-inari_RESULTS.json | 50b1c965c842ced25b2930c2b71ffb6e2da693872aa464a19fbd9d5d9efa0ca7 |

The finite theorem below does not use Tao's sufficiently-large-`n` theorem and
does not assert any explicit Tao threshold. -/

/-- IEEE 1788 certificate: z³ − 1 maximises lemniscate length for n = 3. -/
axiom ehp_cert_3  (p : ℂ[X]) (hp : p.Monic) (hd : p.natDegree = 3)  :
    arcLength p ≤ arcLength (X ^ 3  - C 1)

/-- IEEE 1788 certificate: z⁴ − 1 maximises lemniscate length for n = 4. -/
axiom ehp_cert_4  (p : ℂ[X]) (hp : p.Monic) (hd : p.natDegree = 4)  :
    arcLength p ≤ arcLength (X ^ 4  - C 1)

/-- IEEE 1788 certificate: z⁵ − 1 maximises lemniscate length for n = 5. -/
axiom ehp_cert_5  (p : ℂ[X]) (hp : p.Monic) (hd : p.natDegree = 5)  :
    arcLength p ≤ arcLength (X ^ 5  - C 1)

/-- IEEE 1788 certificate: z⁶ − 1 maximises lemniscate length for n = 6. -/
axiom ehp_cert_6  (p : ℂ[X]) (hp : p.Monic) (hd : p.natDegree = 6)  :
    arcLength p ≤ arcLength (X ^ 6  - C 1)

/-- IEEE 1788 certificate: z⁷ − 1 maximises lemniscate length for n = 7. -/
axiom ehp_cert_7  (p : ℂ[X]) (hp : p.Monic) (hd : p.natDegree = 7)  :
    arcLength p ≤ arcLength (X ^ 7  - C 1)

/-- IEEE 1788 certificate: z⁸ − 1 maximises lemniscate length for n = 8. -/
axiom ehp_cert_8  (p : ℂ[X]) (hp : p.Monic) (hd : p.natDegree = 8)  :
    arcLength p ≤ arcLength (X ^ 8  - C 1)

/-- IEEE 1788 certificate: z⁹ − 1 maximises lemniscate length for n = 9. -/
axiom ehp_cert_9  (p : ℂ[X]) (hp : p.Monic) (hd : p.natDegree = 9)  :
    arcLength p ≤ arcLength (X ^ 9  - C 1)

/-- IEEE 1788 certificate: z¹⁰ − 1 maximises lemniscate length for n = 10. -/
axiom ehp_cert_10 (p : ℂ[X]) (hp : p.Monic) (hd : p.natDegree = 10) :
    arcLength p ≤ arcLength (X ^ 10 - C 1)

/-- IEEE 1788 certificate: z¹¹ − 1 maximises lemniscate length for n = 11. -/
axiom ehp_cert_11 (p : ℂ[X]) (hp : p.Monic) (hd : p.natDegree = 11) :
    arcLength p ≤ arcLength (X ^ 11 - C 1)

/-- IEEE 1788 certificate: z¹² − 1 maximises lemniscate length for n = 12. -/
axiom ehp_cert_12 (p : ℂ[X]) (hp : p.Monic) (hd : p.natDegree = 12) :
    arcLength p ≤ arcLength (X ^ 12 - C 1)

/-- IEEE 1788 certificate: z¹³ − 1 maximises lemniscate length for n = 13.
    Verified with Rust/inari (MPFR-backed directed rounding). -/
axiom ehp_cert_13 (p : ℂ[X]) (hp : p.Monic) (hd : p.natDegree = 13) :
    arcLength p ≤ arcLength (X ^ 13 - C 1)

/-- IEEE 1788 certificate: z¹⁴ − 1 maximises lemniscate length for n = 14.
    Verified with Rust/inari (MPFR-backed directed rounding). -/
axiom ehp_cert_14 (p : ℂ[X]) (hp : p.Monic) (hd : p.natDegree = 14) :
    arcLength p ≤ arcLength (X ^ 14 - C 1)

-- The finite certificate theorems below are intentionally left without problem
-- status tags until maintainers decide how explicit external certificate axioms
-- should be categorized.
set_option linter.style.ams_attribute false
set_option linter.style.category_attribute false

/-- **Erdős Problem 114, small $n$** (finite range, computationally certified).
For $3 \leq n \leq 14$, the polynomial $z^n - 1$ maximises the arc length of
the lemniscate among all monic polynomials of degree $n$.

Proof: decidable case split on $n$; each case discharged by the corresponding
IEEE 1788 certificate axiom above.  The finite theorem itself has no `sorry`
stub; its non-trivial inputs are explicit `axiom` declarations with full
computational citations.

*Reference:* K. Mendoza (2026).
[doi:10.5281/zenodo.19480329](https://doi.org/10.5281/zenodo.19480329) -/
theorem erdos_114_small_n (n : ℕ) (hn : 3 ≤ n) (hn14 : n ≤ 14)
    (p : ℂ[X]) (hp : p.Monic) (hp_deg : p.natDegree = n) :
    arcLength p ≤ arcLength (X ^ n - C 1) := by
  interval_cases n
  · exact ehp_cert_3  p hp hp_deg
  · exact ehp_cert_4  p hp hp_deg
  · exact ehp_cert_5  p hp hp_deg
  · exact ehp_cert_6  p hp hp_deg
  · exact ehp_cert_7  p hp hp_deg
  · exact ehp_cert_8  p hp hp_deg
  · exact ehp_cert_9  p hp hp_deg
  · exact ehp_cert_10 p hp hp_deg
  · exact ehp_cert_11 p hp hp_deg
  · exact ehp_cert_12 p hp hp_deg
  · exact ehp_cert_13 p hp hp_deg
  · exact ehp_cert_14 p hp hp_deg

/-- **Erdős Problem 114, finite range `1 <= n < 15`.**
For every monic complex polynomial `p` of degree `n` with `1 ≤ n < 15`,
the EHP lemniscate inequality holds.

This is a finite variant only.  It combines the direct `n = 1` row, the
MacLane / Eremenko--Hayman `n = 2` row, and the explicit interval-certificate
axioms for `3 ≤ n ≤ 14`.  It does not use or bridge Tao's sufficiently-large
`n` theorem, does not assert a threshold for that theorem, and does not change
the status of the all-degree conjecture `erdos_114`, which remains open in this
file. -/
theorem erdos_114_finite_lt_15 (n : ℕ) (hn : 1 ≤ n) (hn15 : n < 15)
    (p : ℂ[X]) (hp : p.Monic) (hp_deg : p.natDegree = n) :
    arcLength p ≤ arcLength (X ^ n - C 1) := by
  interval_cases n
  · exact ehp_cert_1_direct p hp hp_deg
  · exact ehp_cert_2_eremenko_hayman p hp hp_deg
  · exact ehp_cert_3  p hp hp_deg
  · exact ehp_cert_4  p hp hp_deg
  · exact ehp_cert_5  p hp hp_deg
  · exact ehp_cert_6  p hp hp_deg
  · exact ehp_cert_7  p hp hp_deg
  · exact ehp_cert_8  p hp hp_deg
  · exact ehp_cert_9  p hp hp_deg
  · exact ehp_cert_10 p hp hp_deg
  · exact ehp_cert_11 p hp hp_deg
  · exact ehp_cert_12 p hp hp_deg
  · exact ehp_cert_13 p hp hp_deg
  · exact ehp_cert_14 p hp hp_deg

end Erdos114
