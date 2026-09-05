import 'package:flutter/widgets.dart';

import '../../components/button.dart';
import '../contract/skin_contract_kit.dart';

/// The certified button of the skin lane.
///
/// Wraps [ShadButton] with the typed contract protocol
/// (`contractId == 'zfa.button'`, [contractEnabled]). The pilot auditor's
/// duck-typed `.onPressed` probe becomes a typed read.
///
/// ```dart
/// ZfaButton(
///   onPressed: submit,
///   child: const Text('Continue'),
/// )
/// ```
class ZfaButton extends StatelessWidget with ZfaContract {
  /// Creates a certified button.
  const ZfaButton({
    super.key,
    this.onPressed,
    this.child,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.width,
    this.height,
    this.contractEnabled = true,
  });

  /// {@template ZfaButton.onPressed}
  /// Called when the button is tapped.
  /// {@endtemplate}
  final VoidCallback? onPressed;

  /// The main content of the button.
  final Widget? child;

  /// The widget displayed before [child].
  final Widget? leading;

  /// The widget displayed after [child].
  final Widget? trailing;

  /// Whether the button is enabled.
  final bool enabled;

  /// Whether the button autofocuses.
  final bool autofocus;

  /// The focus node of the button.
  final FocusNode? focusNode;

  /// The fixed width of the button.
  final double? width;

  /// The fixed height of the button.
  final double? height;

  @override
  final String contractId = 'zfa.button';

  @override
  final bool contractEnabled;

  @override
  Widget build(BuildContext context) {
    return ShadButton(
      onPressed: onPressed,
      child: child,
      leading: leading,
      trailing: trailing,
      enabled: enabled,
      autofocus: autofocus,
      focusNode: focusNode,
      width: width,
      height: height,
    );
  }
}
