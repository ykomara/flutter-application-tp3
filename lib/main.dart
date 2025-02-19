import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'bloc/login_bloc.dart';
import 'login_screen.dart';
import 'restaurant_list_screen.dart';
import 'details_screen.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/restaurants',
      builder: (BuildContext context, GoRouterState state) {
        return const RestaurantListScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details/:name/:location',
          builder: (BuildContext context, GoRouterState state) {
            final String name = Uri.decodeComponent(state.pathParameters['name']!);
            final String location = Uri.decodeComponent(state.pathParameters['location']!);

            return DetailsScreen(name: name, location: location);
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: MaterialApp.router(
        title: 'Bars & Restaurants',
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), 
          Locale('es'), 
          Locale('fr'), 
        ],
        builder: (context, child) {
          Locale currentLocale = Localizations.localeOf(context);
          print("Langue actuelle : ${currentLocale.languageCode}");

          return Localizations.override(
            context: context,
            locale: const Locale('fr'),
            child: child!,
          );
        },
      ),
    );
  }
}
