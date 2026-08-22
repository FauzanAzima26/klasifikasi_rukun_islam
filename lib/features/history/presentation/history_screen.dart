import 'package:flutter/material.dart';

import '../../classification/widgets/app_search_bar.dart';
import '../../classification/widgets/filter_dropdown.dart';
import '../models/history_item.dart';
import '../widgets/history_list_item.dart';
import '../widgets/history_empty_state.dart';
import '../widgets/delete_dialog.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/database/hive_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<String> _filters = const [
    'Semua',
    'Syahadat',
    'Shalat',
    'Zakat',
    'Puasa',
    'Haji',
    'Non-Rukun Islam',
  ];

  String _query = '';
  String _selectedFilter = 'Semua';
  List<HistoryItem> _items = [];

  List<HistoryItem> get _filteredItems {
    final q = _query.toLowerCase();
    return _items.where((it) {
      final matchesFilter =
          _selectedFilter == 'Semua' || it.label == _selectedFilter;
      final matchesQuery =
          it.surahName.toLowerCase().contains(q) ||
          it.translation.toLowerCase().contains(q) ||
          it.label.toLowerCase().contains(q) ||
          it.verseNumber.toString().contains(q);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  Future<void> _handleDelete(HistoryItem item) async {
    showDialog<void>(
      context: context,
      builder: (_) => DeleteDialog(
        title: 'Hapus riwayat ini?',
        onConfirm: () async {
          await HiveService.box.delete(item.id);

          _loadHistory();

          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Riwayat berhasil dihapus.')),
          );
        },
      ),
    );
  }

  void _handleOpen(HistoryItem item) {
    // Open result screen (dummy) by navigating to /result
    Navigator.pushNamed(context, '/result');
  }

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    final box = HiveService.box;

    final items = <HistoryItem>[];

    for (final key in box.keys.toList().reversed) {
      final rawData = box.get(key);

      if (rawData is Map) {
        final data = Map<String, dynamic>.from(rawData);

        items.add(HistoryItem.fromHive(key, data));
      }
    }

    setState(() {
      _items = items;
    });
  }

  Future<void> _handleClearHistory() async {
    if (_items.isEmpty) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus semua riwayat?'),
          content: const Text('Semua riwayat klasifikasi akan dihapus.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    await HiveService.clearHistory();

    _loadHistory();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Semua riwayat berhasil dihapus.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredItems;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Riwayat',
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _handleClearHistory,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSearchBar(
                onChanged: (value) {
                  setState(() {
                    _query = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              FilterDropdown(
                selectedValue: _selectedFilter,
                options: _filters,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedFilter = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: filtered.isEmpty
                    ? const HistoryEmptyState()
                    : ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = filtered[index];
                          return HistoryListItem(
                            item: item,
                            onTap: () => _handleOpen(item),
                            onDelete: () => _handleDelete(item),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
