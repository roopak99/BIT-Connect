import 'package:bit_connect/providers/auth.dart';
import 'package:bit_connect/providers/events.dart';
import 'package:bit_connect/screens/club_subscription_screen.dart';
import 'package:bit_connect/screens/event_detail_screen.dart';
import 'package:bit_connect/screens/events_overview_screen.dart';
import 'package:bit_connect/screens/settings.dart';
import 'package:bit_connect/screens/splash_screen.dart';
import 'package:bit_connect/screens/user_detail_screen.dart';
import 'package:bit_connect/screens/user_events_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/edit_event_screen.dart';
import './screens/auth_screen.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Events>(
            create: (ctx) => Events(
              '_',
              '_',
              [],
            ),
            update: (ctx, auth, previousEvents) => Events(
              auth.token,
              auth.userId,
              previousEvents == null ? [] : previousEvents.events,
            ),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BIT Connect',
            // theme: ThemeData(
            //   primarySwatch: Colors.blue,
            //   buttonColor: Color.fromRGBO(169, 224, 22, 1),
            //   appBarTheme:
            //       AppBarTheme(backgroundColor: Color.fromRGBO(39, 39, 39, 1)),
            // ),
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.system,
            home: auth.isAuth
                ? EventsOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              EventsOverviewScreen.routeName: (context) =>
                  EventsOverviewScreen(),
              EventDetail.routeName: (context) => EventDetail(),
              UserEvents.routeName: (context) => UserEvents(),
              EditEventScreen.routeName: (context) => EditEventScreen(),
              Settings.routeName: (context) => Settings(),
              UserDetailScreen.routeName: (context) => UserDetailScreen(),
              ClubSubscriptionScreen.routeName: (context) =>
                  ClubSubscriptionScreen(),
            },
          ),
        ));
  }
}
