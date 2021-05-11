import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rush/l10n/l10n.dart';
import 'package:rush/managment/locale.dart';
import 'package:rush/pages/sign_in_screen.dart';
import 'package:rush/pages/sign_up_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rush/utils/app_theme.dart';

class RushApp extends StatelessWidget {
  final delegates = [
    AppLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleManagment>(
            create: (c) => LocaleManagment()),
      ],
      builder: (c, child) {
        var localeManagment = Provider.of<LocaleManagment>(c);
        return MaterialApp(
          theme: ThemeData(
            fontFamily: "American Typewriter",
            textTheme: AppTheme.Text_Theme,
          ),
          locale: localeManagment.locale ?? Locale("en"),
          localizationsDelegates: delegates,
          supportedLocales: L10n.all,
          initialRoute: SignInScreen.routeName,
          routes: {
            SignUpScreen.routeName: (c) => SignUpScreen(),
            SignInScreen.routeName: (c) => SignInScreen(),
          },
        );
      },
    );
  }
}
