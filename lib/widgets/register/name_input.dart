import 'package:flutter/material.dart';
import 'package:kolizeyfit/widgets/register/styled_input.dart';
import 'package:kolizeyfit/l10n/app_localizations.dart';

class NameInput extends StatelessWidget {
  final TextEditingController controller;

  const NameInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return StyledInput(controller: controller, hintText: local.nameHint);
  }
}
