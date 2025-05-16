// lib/main.dart
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/theme/theme_cubit.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'utils/theme.dart';
import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  runApp(const SilentverceApp());
}

class SilentverceApp extends StatelessWidget {
  const SilentverceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc()..add(AppStarted()),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Silentverce',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            home: const AppEntryPoint(),
          );
        },
      ),
    );
  }
}

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return const HomeScreen();
        } else if (state is Unauthenticated) {
          return const LoginScreen();
        } else {
          // Загрузка при запуске
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterLogo(size: 80),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
