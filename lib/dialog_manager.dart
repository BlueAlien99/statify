import 'package:flutter/material.dart';
import 'package:statify/connector.dart';

class DialogManager {
  // Singleton

  static final DialogManager _dialogManager = DialogManager._();

  factory DialogManager() {
    return _dialogManager;
  }

  DialogManager._();

  // Implementation

  void popAllConnectionStateDialogs(BuildContext context) {
    Navigator.of(context)
        .popUntil((route) => !(route.settings.name?.contains('connectionStateDialog') ?? false));
  }

  AlertDialog connectingDialogBuilder(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 24),
      content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [CircularProgressIndicator(), Text('Connecting...')]),
    );
  }

  AlertDialog connectionErrorDialogBuilder(BuildContext context) {
    return AlertDialog(
      title: const Text("Connection error"),
      content: Text(Connector().lastMessage),
      actions: [TextButton(onPressed: Connector().init, child: const Text('Retry'))],
    );
  }
}
