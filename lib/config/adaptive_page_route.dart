import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


PageRoute<dynamic> adaptivePageRoute(BuildContext context, Widget widget) {
  final ThemeData theme = Theme.of(context);
  return switch(theme.platform) {
    TargetPlatform.iOS || TargetPlatform.macOS =>
      CupertinoPageRoute(
        builder: (context) => widget,
      ),
    _ => MaterialPageRoute(builder: (context) => widget)
  };
}
