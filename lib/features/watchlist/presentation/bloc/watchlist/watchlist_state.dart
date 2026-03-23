part of 'watchlist_bloc.dart';

@immutable
sealed class WatchlistState {}

final class WatchlistInitial extends WatchlistState {}

class WatchListLoaded extends WatchlistState {
  final List<Stock> stocks;
  final int selectedTab;

  WatchListLoaded({required this.stocks, required this.selectedTab});

  WatchListLoaded copyWith({List<Stock>? stocks, int? selectedTab}) {
    return WatchListLoaded(
      stocks: stocks ?? this.stocks,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}

class WatchListLoading extends WatchlistState {}