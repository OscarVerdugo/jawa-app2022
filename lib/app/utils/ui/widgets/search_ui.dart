import 'dart:async';

import 'package:flutter/material.dart';

import '../ui.dart';

class UISearch extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String) onSearch;
  final String placeholder;

  UISearch(
      {Key? key,
      required this.controller,
      required this.onSearch,
      required this.placeholder})
      : super(key: key);

  @override
  State<UISearch> createState() => _UISearchState();
}

class _UISearchState extends State<UISearch> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return UITextField(
        onChanged: _onSearchChanged,
        label: "Buscar",
        onClear: () {
          widget.controller.clear();
          widget.onSearch("");
        },
        controller: widget.controller,
        placeholder: widget.placeholder);
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
