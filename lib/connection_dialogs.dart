import 'package:flutter/material.dart';
import 'package:statify/connector.dart';

const String _dialogRoute = '/connectionStateDialog';

void popAllConnectionStateDialogs(BuildContext context) {
  Navigator.of(context)
      .popUntil((route) => !(route.settings.name?.contains(_dialogRoute) ?? false));
}

void showConnectionDialog(BuildContext context, Widget Function(BuildContext) builder) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: builder,
    routeSettings: const RouteSettings(name: _dialogRoute),
  );
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
