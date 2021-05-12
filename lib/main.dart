import 'package:flutter/material.dart';
import 'package:rush/rush.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv.load(fileName: ".configs");
  runApp(RushApp());
}

void main() async {
  await run();
}
