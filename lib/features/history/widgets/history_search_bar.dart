// A lightweight wrapper to reuse AppSearchBar styles if needed elsewhere
import 'package:flutter/material.dart';

import '../../classification/widgets/app_search_bar.dart';

class HistorySearchBar extends StatelessWidget {
  const HistorySearchBar({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppSearchBar(onChanged: onChanged);
  }
}
