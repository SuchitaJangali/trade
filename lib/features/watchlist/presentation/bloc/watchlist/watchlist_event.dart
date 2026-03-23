part of 'watchlist_bloc.dart';

@immutable
sealed class WatchlistEvent {}
class LoadWatchlist extends WatchlistEvent {}

class ReorderWatchlist extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  ReorderWatchlist({required this.oldIndex, required this.newIndex});

  
}

class ChangeTabEvent extends WatchlistEvent {
  final int index;

  ChangeTabEvent(this.index);
}
