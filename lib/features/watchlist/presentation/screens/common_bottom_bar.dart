
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade/config/theme/app_colors.dart';
import 'package:trade/features/watchlist/presentation/screens/watchlist_screen.dart';

import '../bloc/watchlist/watchlist_bloc.dart';

class CommonBottomBar extends StatefulWidget {
  const CommonBottomBar({super.key});

  static const String routeName = "/CommonBottomBar";
  @override
  State<CommonBottomBar> createState() => _CommonBottomBarState();
}

class _CommonBottomBarState extends State<CommonBottomBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  final items = [
    {'icon': Icons.bookmark_border, 'label': 'Watchlist'},
    {'icon': Icons.bar_chart, 'label': 'Orders'},
    {'icon': Icons.pie_chart_outline, 'label': 'GTT'},
    {'icon': Icons.account_balance_wallet_outlined, 'label': 'Funds'},
    {'icon': Icons.person_outline, 'label': 'Profile'},
  ];
  final List<Widget> _pages = [
    WatchlistScreen(),
     WatchlistScreen(),
    WatchlistScreen(),
    WatchlistScreen(),
     WatchlistScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: items.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Fixed AppBar, title changes with tab
      // ✅ Body: TabBarView takes full height
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => WatchlistBloc())
        ],
        child: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ),
      ),

      // ✅ Bottom TabBar
      bottomNavigationBar: Material(
        // color: context.surface,
        child: SafeArea(
          child: TabBar(
            dividerColor: Colors.transparent,
            controller: _tabController,
            labelColor: AppColors.lightText,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.lightPrimary,
            tabs: List.generate(
  items.length,
  (index) {
    return Tab(
      icon: Icon(items[index]['icon'] as IconData),
      text: items[index]['label'] as String,
    );
  },
),
        ),
      ),),);
  }
}
