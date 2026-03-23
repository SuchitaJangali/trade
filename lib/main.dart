import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade/config/routes/routes.dart';
import 'package:trade/features/watchlist/presentation/screens/splash_screen.dart';

import 'config/theme/app_theme.dart' ;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return MaterialApp(
          title: 'Watchlist',
          debugShowCheckedModeBanner: false,
          theme:AppTheme.light,
          initialRoute: SplashScreen.routeName,
          onGenerateRoute: generateRoute,
          // home: const WatchlistScreen(),
        );
      }
    );
  }
}
