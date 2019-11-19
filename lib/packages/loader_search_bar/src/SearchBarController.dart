import 'package:b2s_driver/packages/loader_search_bar/src/SearchBarState.dart';
import 'package:flutter/foundation.dart';

class SearchBarController {
  SearchBarController({
    this.onCancelSearch,
    this.onClearQuery,
    this.onActivatedChanged,
  });

  final VoidCallback onCancelSearch;
  final VoidCallback onClearQuery;
  final ValueChanged<bool> onActivatedChanged;

  SearchBarState state;

  void setQueryText(String text) => state?.queryInputController?.text = text;
  void startSearch({forceFocus = true}) => state?.activate(forceFocus);
  void cancelSearch() => state?.onCancelSearch();
  void clearQuery() => state?.onClearQuery();
  bool get isEmpty => state != null ? !state.queryNotEmpty : null;
  bool get isActivated => state.activated;
  bool get isFocused => state.focused;
}
