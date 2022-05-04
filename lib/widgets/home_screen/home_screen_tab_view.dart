import 'package:flutter/material.dart';
import 'package:statify/widgets/home_screen/cover_image.dart';
import 'package:statify/widgets/home_screen/object_name.dart';
import 'package:statify/widgets/screen_padding.dart';

class HomeScreenTabView extends StatelessWidget {
  final String? name;
  final String? coverImageUrl;
  final Icon coverImagePlaceholder;
  final List<Widget> children;

  const HomeScreenTabView(
      {Key? key,
      required this.name,
      this.coverImageUrl,
      required this.coverImagePlaceholder,
      this.children = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      CoverImage(url: coverImageUrl, placeholder: coverImagePlaceholder),
      ObjectName(name: name),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Divider(
          color: Colors.blueGrey,
        ),
      ),
      ...children,
      const ScreenPadding(),
    ]));
  }
}
