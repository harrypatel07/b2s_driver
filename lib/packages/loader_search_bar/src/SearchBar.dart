import 'dart:ui';


import 'package:b2s_driver/packages/loader_search_bar/loader_search_bar.dart';
import 'package:b2s_driver/packages/loader_search_bar/src/SearchBarState.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'QuerySetLoader.dart';
import 'SearchBarAttrs.dart';
import 'SearchItem.dart';

/// Search field widget displayed within Scaffold element.
/// Depending on its state and passed attributes it can be rendered
/// as an appBar action, expanded to its full size when activated or merged
/// with appBar, making the search field visible although not activated.
///
/// SearchBar needs to be placed underneath Scaffold element in the
/// widget tree, in place of the original AppBar.
///
/// Specifying [onQueryChanged], [onQuerySubmitted] allows to receive callbacks
/// whenever user input occurs.
/// If [loader] argument is passed, data set will be automatically loaded when
/// query changes (or is submitted). When it happens, widget will change its
/// preferred size requested by Scaffold ancestor, making the ListView take
/// whole available space below app bar. Once user cancels search action
/// (navigates back) widget is rebuilt with default app bar size making
/// Scaffold body visible again.
class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  SearchBar({
    @required this.defaultBar,
    this.onQueryChanged,
    this.onQuerySubmitted,
    this.loader,
    this.overlayStyle,
    this.searchHint = 'Chạm để tìm kiếm...',
    this.initialQuery,
    this.controller,
    this.iconified = true,
    bool autofocus,
    AutoActive autoActive,
    SearchItem searchItem,
    SearchBarAttrs attrs,
  })  : this.autoActive = autoActive ?? AutoActive.off,
        this.autofocus = autofocus ?? iconified,
        this.searchItem = searchItem ?? SearchItem.action(),
        this.attrs = _initAttrs(iconified, attrs);

  static SearchBarAttrs _initAttrs(bool iconified, SearchBarAttrs attrs) {
    final defaultAttrs = iconified
        ? SearchBarAttrs.defaultIconified()
        : SearchBarAttrs.defaultMerged();
    return attrs != null ? defaultAttrs.merge(attrs) : defaultAttrs;
  }

  /// Function being called whenever query changes with its current value
  /// as an argument.
  final ValueChanged<String> onQueryChanged;

  /// Function being called whenever query is submitted with its current value
  /// as an argument.
  final ValueChanged<String> onQuerySubmitted;

  /// Widget automatically loading data corresponding to current query
  /// and displaying it in ListView.
  final QuerySetLoader loader;

  /// SearchBarAttrs instance allowing to specify part of exact values used
  /// during widget building.
  final SearchBarAttrs attrs;

  /// AppBar widget that will be displayed whenever SearchBar is not in
  /// activated state.
  final AppBar defaultBar;

  /// Hint string being displayed until user inputs any text.
  final String searchHint;

  /// Query value displayed for the first time in search field.
  final String initialQuery;

  /// Controller object allowing to access some properties of current state.
  final SearchBarController controller;

  /// Indicating way of representing non-activated SearchBar:
  ///   true if widget should be showed as an action item in defaultAppBar,
  ///   false if widget should be merged with defaultAppBar.
  final bool iconified;

  /// Determining if search field should get focus once it becomes visible.
  final bool autofocus;

  /// Allows to decide if SearchBar should be activated once it becomes
  /// visible for the first time.
  final AutoActive autoActive;

  /// Defining how to position and build search item widget in AppBar.
  final SearchItem searchItem;

  /// Status bar overlay brightness applied when widget is activated.
  final SystemUiOverlayStyle overlayStyle;

  @override
  Size get preferredSize => _shouldTakeWholeSpace
      ? _getAvailableSpace ?? attrs.searchBarSize
      : attrs.searchBarSize;

  bool get _shouldTakeWholeSpace => loader != null && _isThisOrLastActivated;

  bool get _isThisOrLastActivated =>
      SearchBarState.stateHolder[this]?.activated ??
      SearchBarState.stateHolder.lastOrNull?.activated ??
      false;

  Size get _getAvailableSpace {
    final screenSize = MediaQueryData.fromWindow(window).size;
    return Size(screenSize.width, screenSize.height - attrs.loaderBottomMargin);
  }

  @override
  State createState() => SearchBarState.create(this);
}
