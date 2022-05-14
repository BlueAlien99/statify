import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:statify/styles.dart';
import 'package:statify/widgets/data_piece.dart';

class UrlData extends StatelessWidget {
  final String name;
  final String? value;
  final bool canOpen;

  const UrlData({Key? key, required this.name, required this.value, this.canOpen = true})
      : super(key: key);

  void openUrl(BuildContext context) {
    Uri? url = Uri.tryParse(value!);
    if (url != null) {
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void copyUrl(BuildContext context) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$name copied!'),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return const SizedBox.shrink();
    }

    return DataPiece(
      name: name,
      padding: const EdgeInsets.only(left: 8),
      widget: Wrap(
        children: [
          canOpen
              ? TextButton(
                  onPressed: () => openUrl(context),
                  child: const Text('Open'),
                  style: slimTextButtonStyle,
                )
              : const SizedBox.shrink(),
          TextButton(
            onPressed: () => copyUrl(context),
            child: const Text('Copy'),
            style: slimTextButtonStyle,
          )
        ],
      ),
    );
  }
}
