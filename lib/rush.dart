import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rush/blocs/game_bloc.dart';
import 'package:rush/l10n/l10n.dart';
import 'package:rush/managment/game_managment.dart';
import 'package:rush/managment/locale.dart';
import 'package:rush/managment/user_managment.dart';
import 'package:rush/pages/apply_code_screen.dart';
import 'package:rush/pages/home_page.dart';
import 'package:rush/pages/sign_in_screen.dart';
import 'package:rush/pages/sign_up_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rush/utils/app_theme.dart';
import 'package:rush/utils/global_keys.dart';

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
        ChangeNotifierProvider<UserManagment>(
          create: (c) => UserManagment(),
        ),
        ChangeNotifierProvider<GameManagment>(create: (c) => GameManagment()),
        BlocProvider<GameBloc>(
          create: (c) => GameBloc(),
        ),
      ],
      builder: (c, child) {
        var localeManagment = Provider.of<LocaleManagment>(c);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: GlobalKeys.navigatorKey,
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
            ApplyCodeScreen.routeName: (c) => ApplyCodeScreen(),
            HomePage.routeName: (c) => HomePage(),
          },
        );
      },
    );
  }
}
