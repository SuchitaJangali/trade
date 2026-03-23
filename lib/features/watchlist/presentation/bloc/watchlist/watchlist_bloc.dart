
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/stock.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

final List<Stock> sampleStocks = [
  Stock(
    symbol: "RELIANCE",
    name: "Reliance",
    price: 2450,
    change: 10,
    changePercent: 0.4,
  ),
  Stock(
    symbol: "TCS",
    name: "TCS",
    price: 3600,
    change: -15,
    changePercent: -0.3,
  ),
  Stock(
    symbol: "INFY",
    name: "Infosys",
    price: 1400,
    change: 5,
    changePercent: 0.2,
  ),
];
class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistInitial()) {

    // Load initial data
    on<LoadWatchlist>((event, emit) {
      emit(WatchListLoaded(stocks: sampleStocks,selectedTab: 0));
    });

    // Reorder logic
    on<ReorderWatchlist>((event, emit) {
      if (state is WatchListLoaded) {
        final currentState = state as WatchListLoaded;

        final updatedList = List<Stock>.from(currentState.stocks);

        int newIndex = event.newIndex;

        if (newIndex > event.oldIndex) {
          newIndex -= 1;
        }

        final item = updatedList.removeAt(event.oldIndex);
        updatedList.insert(newIndex, item);

       emit(currentState.copyWith(stocks: updatedList));
      }
    });
  
  on<ChangeTabEvent>((event, emit) {
      if (state is WatchListLoaded) {
        final current = state as WatchListLoaded;

        emit(current.copyWith(selectedTab: event.index));
      }
    });
  
  }




}
