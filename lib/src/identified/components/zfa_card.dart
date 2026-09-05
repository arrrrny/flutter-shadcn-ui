import 'package:flutter/widgets.dart';

import '../../components/card.dart';
import '../contract/skin_contract_kit.dart';

/// The certified card of the skin lane.
///
/// Wraps [ShadCard] with the typed contract protocol
/// (`contractId == 'zfa.card'`, [contractEnabled]).
///
/// ```dart
/// const ZfaCard(
///   title: Text('Session'),
///   description: Text('Signed in as skin operator'),
///   child: Text('...'),
/// )
/// ```
class ZfaCard extends StatelessWidget with ZfaContract {
  /// Creates a certified card.
  const ZfaCard({
    super.key,
    this.title,
    this.description,
    this.child,
    this.footer,
    this.leading,
    this.trailing,
    this.contractEnabled = true,
  });

  /// The title widget displayed at the top of the card.
  final Widget? title;

  /// The description widget displayed below the title.
  final Widget? description;

  /// The main content of the card.
  final Widget? child;

  /// The footer widget displayed at the bottom of the card.
  final Widget? footer;

  /// The widget displayed at the start of the card's row.
  final Widget? leading;

  /// The widget displayed at the end of the card's row.
  final Widget? trailing;

  @override
  final String contractId = 'zfa.card';

  @override
  final bool contractEnabled;

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      title: title,
      description: description,
      child: child,
      footer: footer,
      leading: leading,
      trailing: trailing,
    );
  }
}
