import 'package:flutter/material.dart';
import 'package:rush/utils/global_keys.dart';

Future<void> showError({String errorText}) async {
  await showDialog(
    context: GlobalKeys.navigatorKey.currentContext,
    builder: (c) => Dialog(
      child: Text(errorText.toString()),
    ),
  );
}
