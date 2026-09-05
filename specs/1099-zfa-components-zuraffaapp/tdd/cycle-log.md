# Cycle Log: zuraffa_ui — identified Zfa components + ZuraffaApp

Append only. Newest last. Every entry's `red` block is the evidence that the test
existed and failed before the code that satisfies it.

## Baseline

- suite: `flutter test` -> `All tests passed!` (+333, 1m 11s) at fork SHA `afc9569`
- analyze: `flutter analyze` -> 146 issues found (144 error-level, all in the
  `playground/` sub-project; `lib/` and `test/` clean) at fork SHA `afc9569`
- recorded: cycle 0, before any change
- note: the clone's pubspec has no `dependency_overrides` section (the spec's
  deletion step is a no-op; verified by grep). `flutter pub get` resolved the
  package and `example/` against published versions.

## Cycle 1: A1-A4 + U1-U16 the whole test list, red on the shadcn_ui substrate

- test: `test/identified/barrel_surface_test.dart` (new, acceptance),
  `test/identified/zfa_components_test.dart` (new),
  `test/identified/zuraffa_app_test.dart` (new),
  `test/identified/skin_contract_kit_test.dart` (new),
  `test/identified/zfa_theme_test.dart` (new) — the full behavior list
- red: `flutter test test/identified/` -> compile error
  `Target of URI doesn't exist: 'package:zuraffa_ui/zuraffa_ui.dart'` and
  `Error: Couldn't find declaration for ZfaButton / ZuraffaApp / ZfaTheme...`
  (the package resolves as `shadcn_ui`; the identified layer does not exist).
  Recorded verbatim in `tdd/verification.md`.
- green: not attempted. This is the outer loop opening; it stays red until the
  repackage and the identified layer land. State left `RED` deliberately.
- commit: (tests + spec docs only, no implementation)

## Cycle 2: repackage rename — engine carried over, identified layer still red

- change: pubspec `name: zuraffa_ui` / `version: 0.1.0`;
  `git mv lib/shadcn_ui.dart lib/shad.dart`; repo-wide
  `package:shadcn_ui/` -> `package:zuraffa_ui/` rewrite
- red (still): `flutter test test/identified/` ->
  `Error: Couldn't find declaration for 'ZfaButton'` etc. (package now resolves,
  the certified vocabulary does not exist yet)
- green (carried over): `flutter test` -> `All tests passed!` (+333) — the fork's
  engine tests keep running inside the renamed package (C1)
- commit: (repackage only, identified layer not yet written)

## Cycle 3: the identified layer — all behaviors green

- change: `lib/src/identified/` (contract kit, six Zfa components, ZuraffaApp,
  theme aliases) + `lib/zuraffa_ui.dart` barrel + CHANGELOG entry
- green: `flutter test` -> all tests passed (+333 engine, +26 identified)
- commit: (implementation)

## Cycle 4: hardening — format, analyze, docs

- change: `dart format .` (zero residual diff, committed), README re-badge,
  analyzer check vs baseline (no new issues in lib/ + test/)
- suite: re-run green after formatting
- commit: (hardening)

## Cycle 5: verification audit

- change: `tdd/verification.md` written from cold context; deliberate mutants
  executed on high-risk behaviors (each restored, suite re-run green)
- commit: (verification docs)
