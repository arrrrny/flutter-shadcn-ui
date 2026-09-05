---
detected_at: afc9569
ecosystems: [dart]
default: dart
stacks:
  dart:
    cwd: .
    runner: flutter test
    single: flutter test {file} --plain-name "{name}"
    file: flutter test {file}
    suite: flutter test
    watch: null
    coverage: null
    mutation: null
    acceptance: flutter test {file}
    property: null
    approval: flutter test (matchesGoldenFile)
    contract: null
    test_glob: "test/**/*_test.dart"
    exemplar:
      unit: test/src/components/button_test.dart
      acceptance: test/identified/barrel_surface_test.dart
    helpers: []
verified: [file, suite, acceptance]
suite_baseline: green
suite_seconds: 71
notes: >-
  No Dart mutation tool in this environment; mutation evidence is produced via
  the deliberate-mutant procedure from the TDD rubric (break, observe, restore,
  re-run). StrykerJS is not applicable to Dart.
