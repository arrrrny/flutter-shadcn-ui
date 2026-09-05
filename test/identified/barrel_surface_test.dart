import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zuraffa_ui.dart' as zfa;

// The acceptance tests for the repackage. They read the repository as files
// (identity, barrel surface, import hygiene) and compile the certified
// vocabulary from the package barrel. On the shadcn_ui substrate every one of
// these fails: the package resolves as `shadcn_ui`, there is no
// `lib/zuraffa_ui.dart`, and `package:zuraffa_ui/zuraffa_ui.dart` cannot be
// resolved at all.
//
// The import hygiene scan builds its needle from fragments so this file never
// contains the literal it is scanning for.
const String _needle = 'package:shadcn_' 'ui/';

void main() {
  group('package identity', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final changelog = File('CHANGELOG.md').readAsStringSync();

    test('pubspec declares zuraffa_ui at 0.1.0', () {
      final name = RegExp(r'^name:\s*(\S+)', multiLine: true)
          .firstMatch(pubspec)
          ?.group(1);
      final version = RegExp(r'^version:\s*(\S+)', multiLine: true)
          .firstMatch(pubspec)
          ?.group(1);
      expect(name, 'zuraffa_ui', reason: 'pubspec name must be zuraffa_ui');
      expect(
        version,
        '0.1.0',
        reason: 'zuraffa_ui owns its own semver timeline starting at 0.1.0',
      );
    });

    test('raw engine library is lib/shad.dart, not lib/shadcn_ui.dart', () {
      expect(File('lib/shad.dart').existsSync(), isTrue,
          reason: 'raw Shad* engine must live at lib/shad.dart');
      expect(File('lib/shadcn_ui.dart').existsSync(), isFalse,
          reason: 'the upstream barrel path must be gone');
      expect(File('lib/zuraffa_ui.dart').existsSync(), isTrue,
          reason: 'the package barrel must be lib/zuraffa_ui.dart');
    });

    test('CHANGELOG records base fork SHA and upstream version', () {
      expect(changelog, contains('afc9569'),
          reason: 'the base fork SHA of this repackage must be recorded');
      expect(changelog, contains('0.56.3'),
          reason: 'the upstream shadcn_ui version must be recorded');
    });
  });

  group('barrel surface', () {
    final barrel = File('lib/zuraffa_ui.dart').readAsStringSync();
    final exports = RegExp(r"^export\s+'([^']+)'", multiLine: true)
        .allMatches(barrel)
        .map((m) => m.group(1)!)
        .toList();

    test('barrel exists and exports only the identified layer', () {
      expect(exports, isNotEmpty,
          reason: 'the package barrel must export something');
      for (final path in exports) {
        expect(
          path,
          startsWith('src/identified/'),
          reason:
              'barrel must only export lib/src/identified/*, got export of '
              '"$path" — raw Shad* names are internal (lib/shad.dart), never '
              'the package barrel',
        );
      }
    });

    test('barrel does not re-export the raw engine', () {
      expect(barrel, isNot(contains("export 'src/app.dart'")));
      expect(barrel, isNot(contains("export 'src/components/")));
      expect(barrel, isNot(contains("export 'src/theme/")));
      expect(barrel, isNot(contains("export 'shad.dart'")));
    });

    test('certified vocabulary compiles from the barrel', () {
      // Compile-time proof that every certified name resolves through
      // package:zuraffa_ui/zuraffa_ui.dart. If any name is missing from the
      // barrel the test file itself does not compile.
      final List<Type> vocabulary = [
        zfa.ZuraffaApp,
        zfa.ZfaButton,
        zfa.ZfaInput,
        zfa.ZfaCard,
        zfa.ZfaSheet,
        zfa.ZfaToaster,
        zfa.ZfaDialog,
        zfa.ZfaTheme,
        zfa.ZfaThemeData,
        zfa.ZfaAuditBus,
        zfa.ZfaContractViolation,
        zfa.ZfaContract,
        zfa.ZuraffaRouteObserver,
        zfa.SkinContractKit,
      ];
      expect(vocabulary, hasLength(14));
      // And the contract protocol is typed on the certified names.
      const zfa.ZfaButton button = zfa.ZfaButton();
      expect(button.contractId, 'zfa.button');
      expect(button.contractEnabled, isTrue);
    });
  });

  group('import hygiene', () {
    test('no file imports the shadcn_ui package anywhere in the repo', () {
      final offenders = <String>[];
      for (final dir in ['lib', 'test', 'example', 'playground', 'cli']) {
        final root = Directory(dir);
        if (!root.existsSync()) continue;
        for (final entity in root.listSync(recursive: true)) {
          if (entity is! File) continue;
          if (!entity.path.endsWith('.dart')) continue;
          if (entity.path.contains('.specify') ||
              entity.path.contains('.agents')) {
            continue;
          }
          if (entity.readAsStringSync().contains(_needle)) {
            offenders.add(entity.path);
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'downstream must import package:zuraffa_ui/... only; these files '
            'still import the shadcn_ui package: $offenders',
      );
    });
  });
}
