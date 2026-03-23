
import 'package:flutter/material.dart';
import 'package:trade/features/watchlist/presentation/screens/splash_screen.dart';

import '../../features/watchlist/presentation/screens/common_bottom_bar.dart';
import '../../features/watchlist/presentation/screens/edit_watchlist_screen.dart' ;

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SplashScreen.routeName:
    return
      MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>SplashScreen());

    case CommonBottomBar.routeName:
    return
      MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CommonBottomBar());
    case EditWatchlistScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => EditWatchlistScreen(),
      );
    
    default:
       return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Scaffold(
          body: Center(child: Text('Screen does not exist! $routeSettings')),
        ),
      );
  }
  
  }