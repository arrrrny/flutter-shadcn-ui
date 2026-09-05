# Tasks: zuraffa_ui — identified Zfa components + ZuraffaApp

**Feature Branch**: `1099-zfa-components-zuraffaapp`

## 1. Tests (RED first — no implementation commits before the tests exist)

- [x] T1: Write acceptance tests: package identity (pubspec name/version,
      CHANGELOG records base SHA + upstream version), barrel surface scan
      (no raw Shad* exports), import hygiene (zero `package:shadcn_ui/` in
      lib/test/example/playground).
- [x] T2: Write identification tests: contractId/contractEnabled on ZfaButton,
      ZfaInput, ZfaCard, ZfaSheet, ZfaToaster, ZfaDialog + rendering.
- [x] T3: Write ZuraffaApp tests: observer violation on unnamed route push,
      named route clean, chrome banner visibility, chrome disable flag,
      user builder preserved.
- [x] T4: Write contract-kit tests: bus report/clear/notify, route observer
      reporting, ZfaContract mixin, zfa-key convention parsing.
- [x] T5: Write theme alias tests: ZfaTheme.of resolves ShadTheme,
      ZfaThemeData constructs.
- [x] T6: Record red evidence in `tdd/cycle-log.md`; commit tests + docs first
      (test-first git history).

## 2. Repackage

- [x] T7: pubspec.yaml → `name: zuraffa_ui`, `version: 0.1.0`, re-badged
      description; keep engine deps as published versions (no path overrides —
      verified: the fork's pubspec has no `dependency_overrides` section).
- [x] T8: `git mv lib/shadcn_ui.dart lib/shad.dart` (content unchanged).
- [x] T9: Rewrite all `package:shadcn_ui/` → `package:zuraffa_ui/`
      (lib/, test/, example/, playground/).
- [x] T10: Engine suite carried over green (same 333 tests).

## 3. Identified layer (GREEN)

- [x] T11: `lib/src/identified/contract/skin_contract_kit.dart` — ZfaContract
      mixin, ZfaContractViolation, ZfaAuditBus, ZuraffaRouteObserver,
      SkinContractKit, zfa-key parsing.
- [x] T12: Six Zfa components under `lib/src/identified/components/`.
- [x] T13: `lib/src/identified/app/zuraffa_app.dart` + violation chrome.
- [x] T14: `lib/src/identified/theme/zfa_theme.dart` aliases.
- [x] T15: `lib/zuraffa_ui.dart` barrel — identified surface only.
- [x] T16: All new tests green; full suite green.

## 4. Hardening & docs

- [x] T17: README re-badged (zuraffa_ui title/intro; engine history preserved).
- [x] T18: CHANGELOG entry: base fork SHA `afc9569` + upstream version 0.56.3.
- [x] T19: `flutter analyze` — no new issues vs baseline (package lib/test clean).
- [x] T20: `dart format .` — zero diff after formatting; commit.
- [x] T21: Cycle log updated through green; red evidence intact.

## 5. Verification

- [x] T22: Run /speckit.tdd.verify discipline: cold-context audit, deliberate
      mutants on high-risk behaviors (restored + suite re-run green), write
      `tdd/verification.md` with verdict, findings, remediation.
- [x] T23: Push branch, open PR to master, `Closes #1099`.
