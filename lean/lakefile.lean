/-
Lake configuration for using this repository as a Lake dependency.

This is the branch `lake-dependency` of github.com/jingyuanli-hk/openai_math, whose branch `main` is
github.com/openai/math. The branch differs from `main` only in this file.

Why. The upstream `lean/lakefile.lean` requires 41 further packages, and when Lake loads it, it clones and
patches 11 of them into this package's own `.lake/packages` folder and then checks them in a `post_update` hook.
Lake keeps all packages of a workspace in the root package's `.lake/packages` and runs the `post_update` hooks
of every package, so that check stops `lake update` when this package is a dependency.

What. This file requires only Mathlib, at the revision of the upstream `lean/lake-manifest.json`, and keeps the
upstream option `autoImplicit := false`. The single library `OAI` makes every module `OAI.*` buildable; Lake
builds only the modules that a dependent package imports. Modules that import another package (for example
Carleson or PrimeNumberTheoremAnd) cannot be built through this file.

Updating. Merge upstream `main` into this branch (do not rebase or force-push, so that the commits that
dependents pin stay reachable), keep this file, and check the Mathlib revision against the upstream manifest.
-/
import Lake
open Lake DSL

package OAI where
  version := v!"0.1.0"
  leanOptions := #[⟨`autoImplicit, false⟩]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "d13f23b723b8a846827a245b89c10fc7d3f11612"

lean_lib OAI
