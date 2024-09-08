import 'package:flutter/material.dart';
import 'package:flutter_application_pipa_web/src/core/contants.dart';
import 'package:flutter_application_pipa_web/src/pages/login.dart';
import 'package:flutter_application_pipa_web/src/providers/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Colégio PIPA Web',
      theme: ref.watch(themeSwitchProvider) ? kLightTheme : kDarkTheme,
      home: LoginPage(),
    );
  }
}
