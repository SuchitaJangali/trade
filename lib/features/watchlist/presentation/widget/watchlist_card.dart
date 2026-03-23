import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade/config/theme/app_colors.dart';
import 'package:trade/features/watchlist/domain/entities/stock.dart';

class WatchlistCard extends StatelessWidget {
  const WatchlistCard({super.key, required this.stock, required this.priceColor});
  final Stock stock;
  final Color priceColor;

  @override
  Widget build(BuildContext context) {
        final tt = Theme.of(context).textTheme;

    return            
              Column(
      children: [
        ListTile(
          key: ValueKey(stock.symbol),
          contentPadding:  EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 4.h,
          ),
          title: Text(stock.symbol, style: tt.titleSmall),
          subtitle: Text(stock.name, style: tt.labelSmall),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '₹${stock.price}',
                style: tt.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: priceColor,
                ),
              ),
              Text(
                '${stock.change} (${stock.changePercent}%)',
                style: tt.labelSmall?.copyWith(color: AppColors.lightTextMuted),
              ),
            ],
          ),
        ),

         Divider(height: 1.h, color: AppColors.divider),
      ],
    );
   
  }
}