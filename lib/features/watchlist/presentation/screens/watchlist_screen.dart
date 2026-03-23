import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade/config/utils/common_widgets/size.dart';
import 'package:trade/features/watchlist/presentation/screens/edit_watchlist_screen.dart';
import 'package:trade/features/watchlist/presentation/widget/watchlist_card.dart';

import '../../../../config/theme/app_colors.dart' show AppColors;
import '../bloc/watchlist/watchlist_bloc.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  
  @override
  void initState() {
    super.initState();
    context.read<WatchlistBloc>().add(LoadWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              _buildTopBar(tt, cs),
              10.h.height,
              _buildSearchBar(tt, cs),
          
              _buildTabBar(tt, cs),
          
              _buildSortBar(tt, cs,(){
                
  Navigator.pushNamed(context,EditWatchlistScreen.routeName );
              }),
              Expanded(child: _buildWatchlist(tt, cs)),
            ],
          ),
        ),
      ),
    );
  }

  // ── Top index bar ────────────────────────────────────────────────────────

  Widget _buildTopBar(TextTheme tt, ColorScheme cs) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildIndexTile(
              'SENSEX 18TH SEP 8...',
              'BSE',
              '1,225.55',
              '144.50 (13.3...',
              true,
              tt,
              cs,
            ),
          ),
          Container(width: 1, height: 40, color: AppColors.divider),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildIndexTile(
                    'NIFTY BANK',
                    '',
                    '54,173.20',
                    '-13.70 (-0.03...',
                    false,
                    tt,
                    cs,
                  ),
                ),
                Icon(Icons.chevron_right, color: cs.onSurfaceVariant, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndexTile(
    String name,
    String exchange,
    String price,
    String change,
    bool isPositive,
    TextTheme tt,
    ColorScheme cs,
  ) {
    final changeColor = isPositive ? AppColors.gain : AppColors.loss;

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  name,
                  style: tt.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              if (exchange.isNotEmpty) ...[
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightCard,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    exchange,
                    style: tt.labelSmall?.copyWith(
                      fontSize: 9,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ],
          ),
        10.h.height, 
          Row(
            children: [
              Text(
                price,
                style: tt.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  change,
                  style: tt.labelSmall?.copyWith(color: changeColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Search bar ───────────────────────────────────────────────────────────

Widget _buildSearchBar(TextTheme tt, ColorScheme cs) {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric( vertical: 10),
      decoration: BoxDecoration(
        
        color: AppColors.lightBackground.withAlpha(200),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color:  AppColors.lightTextMuted.withAlpha(20),blurRadius: 3,spreadRadius: 10)
        ],
        border: Border.all(color: AppColors.lightCard.withAlpha(255), width: 1),
      ),
      child: TextField(
        decoration: InputDecoration(
        
          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 22),
          hintText: 'Search for instruments',
          hintStyle: tt.bodyMedium?.copyWith(color: Colors.grey, fontSize: 15),
          border: InputBorder.none, // removes default TextField border
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          // contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }  // ── Tab bar ──────────────────────────────────────────────────────────────

  Widget _buildTabBar(TextTheme tt, ColorScheme cs) {
    final tabs = ['Watchlist 1', 'Watchlist 5', 'Watchlist 6'];
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if(state is WatchListLoaded){

        return Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.divider)),
          ),
          child: Row(
            children: tabs.asMap().entries.map((entry) {
              final isSelected = entry.key == state.selectedTab;
              return GestureDetector(
                onTap: () => context.read<WatchlistBloc>().add(ChangeTabEvent(entry.key)),
                child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          entry.value,
                          style: tt.bodyMedium?.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: isSelected
                                ? cs.primary
                                : cs.onSurfaceVariant,
                          ),
                        ),

                         6.h.height,

                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          height: 2.h,
                          width: isSelected ? 60.w : 0,
                          decoration: BoxDecoration(
                            color: cs.primary,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ],
                    ),
                  ),  );
            }).toList(),
          ),
        );
        }
        return 0.h.height;
      },
    );
  }

  // ── Sort bar ─────────────────────────────────────────────────────────────

  Widget _buildSortBar(TextTheme tt, ColorScheme cs,VoidCallback ontap) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
onTap: ontap,
          child: Container     (
             padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          
            decoration: BoxDecoration(
               color: AppColors.neutral.withAlpha(100),
              borderRadius: BorderRadius.circular(10),
                 
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
              Icon(Icons.tune, size: 20,  color: Colors.black),
              10.w.width,
              Text(
                'Sort by',
                style: tt.bodyMedium?.copyWith(color: Colors.black),
              ),
            ],),
          ),
        )
      ),
    );
  }

  // ── Watchlist (BLoC) ─────────────────────────────────────────────────────

  Widget _buildWatchlist(TextTheme tt, ColorScheme cs) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if (state is WatchListLoading) {
          return Center(child: CircularProgressIndicator(color: cs.primary));
        }

        if (state is WatchListLoaded) {
          return ListView.builder(
            itemCount: state.stocks.length,
            itemBuilder: (context, index) {
              final stock = state.stocks[index];
              final isPositive = stock.change >= 0;
              final priceColor = isPositive ? AppColors.gain : AppColors.loss;

              return WatchlistCard(stock: stock, priceColor: priceColor);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
