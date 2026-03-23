import 'package:flutter/material.dart';
import 'package:trade/features/watchlist/presentation/screens/common_bottom_bar.dart';

import '../../../../config/theme/app_colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  @override
   void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    Navigator.pushReplacementNamed(context, CommonBottomBar.routeName); // change route
  }


  @override
  Widget build(BuildContext context) {
    return 

        Scaffold(
        backgroundColor: AppColors.lightBackground, // green background (#34B27D)
        body: SafeArea(
              // Centered logo and app name
       child:       Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Replace this Container with your logo image or widget
                  

              // Bottom centered circular progress indicator
              Center(
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    color: AppColors.lightPrimary,
                    strokeWidth: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
