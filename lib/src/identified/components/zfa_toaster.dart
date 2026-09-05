import 'package:flutter/widgets.dart';

import '../../components/toast.dart';
import '../contract/skin_contract_kit.dart';

/// The certified toaster of the skin lane.
///
/// Wraps [ShadToaster] with the typed contract protocol
/// (`contractId == 'zfa.toaster'`, [contractEnabled]).
///
/// [ZuraffaApp] already mounts a toaster through the engine's app shell, so
/// most skins never construct this directly. Mount it yourself only when you
/// build a custom app shell: place it in your app's `builder`, exactly where
/// the engine places it.
///
/// ```dart
/// ShadApp(
///   builder: (context, child) => ZfaToaster(child: child!),
///   home: ...,
/// )
/// ```
class ZfaToaster extends StatelessWidget with ZfaContract {
  /// Creates a certified toaster wrapping [child].
  const ZfaToaster({
    super.key,
    required this.child,
    this.contractEnabled = true,
  });

  /// The widget below the toaster, over which toasts are displayed.
  final Widget child;

  @override
  final String contractId = 'zfa.toaster';

  @override
  final bool contractEnabled;

  @override
  Widget build(BuildContext context) {
    return ShadToaster(child: child);
  }
}
