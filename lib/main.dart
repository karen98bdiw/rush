import 'package:flutter/material.dart';
import 'package:rush/rush.dart';

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RushApp());
}

void main() async {
  await run();
}
