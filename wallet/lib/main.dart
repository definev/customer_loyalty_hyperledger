/*
*	Copyright PKA.CPD . All Rights Reserved.
*	SPDX-License-Identifier: Apache-2.0
 */

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet/features/dashboard/dashboard_view.dart';
import 'package:wallet/features/sign_in/sign_in_provider.dart';
import 'package:wallet/features/sign_in/sign_in_view.dart';

void main() {
  runApp(const ProviderScope(
    child: App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FlexColorScheme.light(
      useMaterial3: true,
      scheme: FlexScheme.amber,
      textTheme: GoogleFonts.interTextTheme(),
    ).toTheme;
    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('vi', 'VN'), // English
      ],
      useInheritedMediaQuery: true,
      theme: theme.copyWith(
          textTheme: theme.textTheme.apply(
        bodyColor: theme.colorScheme.onBackground,
        displayColor: theme.colorScheme.onBackground,
        decorationColor: theme.colorScheme.onBackground,
      )),
      home: Consumer(
        builder: (context, ref, child) {
          final signInState = ref.watch(signInStateProvider);
          return signInState.map(
            guest: (_) => const SignInView(),
            signedIn: (_) => const DashboardView(),
          );
        },
      ),
    );
  }
}
