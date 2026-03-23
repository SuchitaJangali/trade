import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade/config/theme/app_colors.dart';
import 'package:trade/config/utils/common_widgets/size.dart';
import 'package:trade/features/watchlist/presentation/bloc/watchlist/watchlist_bloc.dart';

class EditWatchlistScreen extends StatefulWidget {
  const EditWatchlistScreen({super.key});


  static const String routeName = "/EditWatchlistScreen";

  @override
  State<EditWatchlistScreen> createState() => _EditWatchlistScreenState();
}

class _EditWatchlistScreenState extends State<EditWatchlistScreen> {
  late TextEditingController _nameController;
  bool _isEditingName = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Watchlist 1');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(tt, cs),
            _buildNameField(tt, cs),
            12.h.height,
            Expanded(child: _buildDraggableList(tt, cs)),
            _buildBottomBar(tt, cs),
          ],
        ),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────────────

  Widget _buildAppBar(TextTheme tt, ColorScheme cs) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
            color: cs.onSurface,
          ),
          Expanded(
            child: Text(
              'Edit Watchlist 1',
              style: tt.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Name Field ───────────────────────────────────────────────────────────

  Widget _buildNameField(TextTheme tt, ColorScheme cs) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.lightCard,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: _isEditingName
                  ? TextField(
                      controller: _nameController,
                      autofocus: true,
                      style: tt.bodyMedium?.copyWith(color: cs.onSurface),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onSubmitted: (_) =>
                          setState(() => _isEditingName = false),
                    )
                  : Text(
                      _nameController.text,
                      style: tt.bodyMedium?.copyWith(color: cs.onSurface),
                    ),
            ),
            GestureDetector(
              onTap: () => setState(() => _isEditingName = !_isEditingName),
              child: Icon(
                _isEditingName ? Icons.check : Icons.edit_outlined,
                size: 18,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Draggable Reorderable List ────────────────────────────────────────────

  Widget _buildDraggableList(TextTheme tt, ColorScheme cs) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if (state is WatchListLoading) {
          return Center(child: CircularProgressIndicator(color: cs.primary));
        }

        if (state is WatchListLoaded) {
          return ReorderableListView.builder(
            itemCount: state.stocks.length,
            buildDefaultDragHandles: false,
            proxyDecorator: (child, index, animation) {

              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Material(
                    elevation: 6,
                    color: cs.surface,
                    shadowColor: cs.shadow.withAlpha(80),
                    borderRadius: BorderRadius.circular(8),
                    child: child,
                  );
                },
                child: child,
              );
            },
            onReorder: (oldIndex, newIndex) {
              // Dispatch reorder event to BLoC
              context.read<WatchlistBloc>().add(
                    ReorderWatchlist(
                      oldIndex: oldIndex,
                      newIndex: newIndex,
                    ),
                  );
            },
            itemBuilder: (context, index) {
              final stock = state.stocks[index];

              return _buildDraggableRow(
                key: ValueKey(stock.symbol),
                index: index,
                symbol: stock.symbol,
                tt: tt,
                cs: cs,
                onDelete: () =>(){},
                
                //  context.read<WatchlistBloc>().add(
                //       RemoveFromWatchlistEvent(symbol: stock.symbol),
                    
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildDraggableRow({
    required Key key,
    required int index,
    required String symbol,
    required TextTheme tt,
    required ColorScheme cs,
    required VoidCallback onDelete,
  }) {
    return Container(
      key: key,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            // ── Drag handle ──────────────────────────────────────────────
            ReorderableDragStartListener(
              index: index,
              child: const Icon(
                Icons.drag_handle,
                color: AppColors.lightTextMuted,
                size: 22,
              ),
            ),

            16.w.width,

            // ── Stock symbol ─────────────────────────────────────────────
            Expanded(
              child: Text(
                symbol,
                style: tt.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // ── Delete button ────────────────────────────────────────────
            GestureDetector(
              onTap: onDelete,
              child: Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Icon(
                  Icons.delete_outline,
                  color: cs.onSurfaceVariant,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Bottom Bar ────────────────────────────────────────────────────────────

  Widget _buildBottomBar(TextTheme tt, ColorScheme cs) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Edit other watchlists
          GestureDetector(
            onTap: () {
              // TODO: navigate to watchlist switcher
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: AppColors.lightCard,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                'Edit other watchlists',
                style: tt.bodyMedium?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          12.h.height,

          // Save Watchlist
          GestureDetector(
            onTap: () {
              // context
              //     .read<WatchlistBloc>()
              //     .add(SaveWatchlistEvent(name: _nameController.text));
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: cs.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                'Save Watchlist',
                style: tt.bodyMedium?.copyWith(
                  color: cs.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}