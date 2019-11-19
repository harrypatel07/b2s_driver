
import 'package:b2s_driver/packages/loader_search_bar/loader_search_bar.dart';
import 'package:b2s_driver/packages/loader_search_bar/src/SearchBarBuilder.dart';
import 'package:b2s_driver/packages/loader_search_bar/src/StateHolder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
abstract class SearchBarState extends State<SearchBar> {
  SearchBarState();

  factory SearchBarState.create(SearchBar searchBar) =>
      searchBar.iconified ? IconifiedBarState() : MergedBarState();

  static final stateHolder = StateHolder<SearchBar, SearchBarState>();

  bool activated = false;

  bool _isClearingQuery = false;

  bool _hasPendingScaffold = false;

  FocusNode searchFocusNode = FocusNode();

  TextEditingController queryInputController;

  String loaderQuery;

  bool get focused => searchFocusNode.hasFocus;

  bool get queryNotEmpty => queryInputController.text.isNotEmpty;

  QuerySetLoader get _safeLoader => widget.loader ?? QuerySetLoader.blank;

  EdgeInsets get screenPadding => MediaQuery.of(context).padding;

  VoidCallback get clearQueryCallback =>
      widget.controller?.onClearQuery ?? onClearQuery;

  VoidCallback get cancelSearchCallback =>
      widget.controller?.onCancelSearch ?? onCancelSearch;

  void handleActivate();
  SearchBarBuilder createBuilder();

  @override
  void initState() {
    super.initState();
    stateHolder.add(this);
    searchFocusNode.addListener(_onSearchFocusChange);
    _initSearchQuery();
    _initAutoActive();
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    queryInputController.dispose();
    stateHolder.remove(this);
    super.dispose();
  }

  void _onSearchFocusChange() {
    if (focused && !activated) {
      setState(() => _updateActivated(true));
    }
  }

  void _initSearchQuery() {
    queryInputController?.dispose();
    queryInputController = TextEditingController(text: widget.initialQuery)
      ..addListener(_onQueryControllerChange);
  }

  void _onQueryControllerChange() {
    if (_isClearingQuery) {
      _isClearingQuery = false;
      onTextChange('');
    }
  }

  void onTextChange(String text) {
    if (_safeLoader.loadOnEachChange) {
      setState(() => loaderQuery = text);
    }
    if (widget.onQueryChanged != null) widget.onQueryChanged(text);
  }

  void onTextSubmit(String text) {
    if (!_safeLoader.loadOnEachChange) {
      setState(() => loaderQuery = text);
    }
    if (widget.onQuerySubmitted != null) widget.onQuerySubmitted(text);
  }

  void _initAutoActive() {
    if (widget.autoActive.shouldActivate(this)) {
      Future(() => activate(false));
    }
  }

  void onCancelSearch() {
    setState(() {
      searchFocusNode.unfocus();
      widget.loader?.clearData();
      loaderQuery = null;
      _updateActivated(false);
    });
  }

  void _updateActivated(bool value) {
    if (activated != value) {
      activated = value;
      widget.controller?.onActivatedChanged?.call(value);
      if (activated) {
        loaderQuery = queryInputController.text;
      }
      _rebuildScaffold();
    }
  }

  void onClearQuery() =>
      queryNotEmpty ? _clearQueryField() : cancelSearchCallback();

  void _clearQueryField() {
    _isClearingQuery = true;
    queryInputController.clear();
    _requestSearchFocus();
  }

  void activate(bool forceFocus) {
    if (!activated) {
      handleActivate();
    }
    if (activated && forceFocus && !focused) {
      _focusSearchField();
    }
  }

  void _focusSearchField() async {
    await Future.doWhile(() => Future(() => _hasPendingScaffold));
    _requestSearchFocus();
  }

  void _rebuildScaffold() {
    if (!_hasPendingScaffold) {
      _hasPendingScaffold = true;
      Future.delayed(Duration(milliseconds: 50), () {
        Scaffold.of(context).setState(() {});
        _hasPendingScaffold = false;
      });
    }
  }

  void onPrefixSearchTap() {
    _requestSearchFocus();
    _highlightQueryText();
  }

  void _requestSearchFocus() =>
      FocusScope.of(context).requestFocus(searchFocusNode);

  void _highlightQueryText() {
    queryInputController.selection = TextSelection(
      baseOffset: queryInputController.value.text.length,
      extentOffset: 0,
    );
  }

  Future<bool> onWillPop() {
    bool shouldPop;
    if (activated) {
      onCancelSearch();
      shouldPop = false;
    } else {
      shouldPop = true;
    }
    return Future.value(shouldPop);
  }

  @override
  Widget build(BuildContext context) {
    widget.controller?.state = this;
    return createBuilder();
  }
}

class MergedBarState extends SearchBarState {
  @override
  void handleActivate() {
    if (widget.autofocus) {
      _requestSearchFocus();
    } else {
      setState(() => _updateActivated(true));
    }
  }

  @override
  SearchBarBuilder createBuilder() => MergedBarBuilder(this, context);
}

class IconifiedBarState extends SearchBarState {
  @override
  void handleActivate() => onSearchAction();

  void onSearchAction() {
    setState(() {
      _initSearchQuery();
      _updateActivated(true);
    });
  }

  @override
  SearchBarBuilder createBuilder() => IconifiedBarBuilder(this, context);
}
