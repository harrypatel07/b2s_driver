
import 'package:b2s_driver/packages/loader_search_bar/loader_search_bar.dart';
import 'package:b2s_driver/packages/loader_search_bar/src/InheritedSearchWidget.dart';
import 'package:b2s_driver/packages/loader_search_bar/src/SearchBarButton.dart';
import 'package:b2s_driver/packages/loader_search_bar/src/SearchBarState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class SearchBarBuilder<T extends SearchBarState>
    extends StatelessWidget {
  SearchBarBuilder(this.searchState, this.searchContext)
      : searchWidget = searchState.widget,
        searchAttrs = searchState.widget.attrs;

  final SearchBar searchWidget;

  final SearchBarAttrs searchAttrs;

  final T searchState;

  final BuildContext searchContext;

  Widget buildInactiveBar();

  @override
  Widget build(BuildContext context) {
    final appBar =
        searchState.activated ? _buildSearchBar() : buildInactiveBar();
    final appBarWidget =
        searchWidget.loader != null ? _wrapWithLoader(appBar) : appBar;
    return WillPopScope(
      onWillPop: searchState.onWillPop,
      child: appBarWidget,
    );
  }

  Widget _wrapWithLoader(Widget appBar) {
    return Stack(
      children: [
        Positioned(
          top: _searchBarTotalHeight,
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: _buildLoaderWidget(),
        ),
        Positioned(
          top: 0.0,
          height: _searchBarTotalHeight,
          left: 0.0,
          right: 0.0,
          child: appBar,
        ),
      ],
    );
  }

  Widget _buildLoaderWidget() {
    return InheritedSearchQuery(
      query: searchState.loaderQuery,
      child: searchWidget.loader,
    );
  }

  Widget _buildSearchBar() {
    return buildBaseBar(
      leading: _buildCancelSearchButton(),
      search: buildSearchStackContainer(),
    );
  }

  Widget buildBaseBar({Widget leading, Widget search, List<Widget> actions}) {
    final barContent = _buildBaseBarContent(leading, search, actions);
    final barWidget = _buildBaseBarWidget(barContent);
    return _wrapWithOverlayIfPresent(barWidget);
  }

  List<Widget> _buildBaseBarContent(
      Widget leading, Widget search, List<Widget> actions) {
    return []
      ..add(Container(width: searchAttrs.searchBarPadding))
      ..add(leading)
      ..add(search)
      ..add(Container(width: searchAttrs.searchBarPadding))
      ..addAll(actions ?? [])
      ..removeWhere((it) => it == null);
  }

  Material _buildBaseBarWidget(List barContent) {
    return Material(
      borderRadius: BorderRadius.zero,
      elevation: searchAttrs.searchBarElevation,
      child: Container(
        height: _searchBarTotalHeight,
        color: searchAttrs.statusBarColor,
        child: SafeArea(
          bottom: false,
          child: Container(
            color: searchAttrs.searchBarColor,
            child: Row(children: barContent),
          ),
        ),
      ),
    );
  }

  Widget _wrapWithOverlayIfPresent(Widget widget) {
    if (searchWidget.overlayStyle != null) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: searchWidget.overlayStyle,
        child: widget,
      );
    } else {
      return widget;
    }
  }

  Widget _buildCancelSearchButton() {
    return SearchBarButton(
      icon: Icons.arrow_back,
      color: searchAttrs.primaryDetailColor,
      onPressed: searchState.cancelSearchCallback,
      marginHorizontal: searchAttrs.cancelSearchMarginLeft,
    );
  }

  Widget buildSearchStackContainer() {
    return Expanded(
      child: Container(
        height: searchAttrs.searchTextFieldHeight,
        margin: searchAttrs.searchInputMargin,
        padding: searchAttrs.searchInputBaseMargin,
        decoration: _buildSearchTextBoxDecoration(),
        child: _buildSearchStack(),
      ),
    );
  }

  Widget _buildSearchStack() {
    return Stack(
      children: [
        _buildSearchTextField(),
        _buildHighlightButton(),
        _shouldShowClear ? _buildClearButton() : null,
      ].where((it) => it != null).toList(),
    );
  }

  bool get _shouldShowClear =>
      searchState.activated && searchState.queryNotEmpty;

  Widget _buildSearchTextField() {
    return Positioned.fill(
      child: Center(
        child: TextField(
          style: searchAttrs.textStyle,
          autofocus: searchWidget.autofocus,
          focusNode: searchState.searchFocusNode,
          controller: searchState.queryInputController,
          onChanged: searchState.onTextChange,
          onSubmitted: searchState.onTextSubmit,
          decoration: _buildSearchTextFieldDecoration(),
        ),
      ),
    );
  }

  BoxDecoration _buildSearchTextBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: searchAttrs.textBoxOutlineColor,
        width: searchAttrs.textBoxOutlineWidth,
      ),
      borderRadius:
          BorderRadius.all(Radius.circular(searchAttrs.textBoxOutlineRadius)),
      color: searchAttrs.textBoxBackgroundColor,
    );
  }

  InputDecoration _buildSearchTextFieldDecoration() {
    return InputDecoration(
      contentPadding: searchAttrs.searchTextFieldPadding,
      border: InputBorder.none,
      hintText: searchWidget.searchHint,
      hintStyle: TextStyle(
          color: !searchState.focused
              ? searchAttrs.secondaryDetailColor
              : searchAttrs.disabledDetailColor),
    );
  }

  Widget _buildHighlightButton() {
    return Positioned(
      left: 0.0,
      top: 0.0,
      bottom: 0.0,
      child: Container(
        margin: searchAttrs.highlightButtonMargin,
        child: SearchBarButton(
          icon: Icons.search,
          color: searchState.queryNotEmpty || !searchState.focused
              ? searchAttrs.primaryDetailColor
              : searchAttrs.secondaryDetailColor,
          onPressed: searchState.onPrefixSearchTap,
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return Positioned(
      right: 0.0,
      top: 0.0,
      bottom: 0.0,
      child: Container(
        margin: searchAttrs.clearButtonMargin,
        child: SearchBarButton(
          icon: Icons.clear,
          color: searchState.queryNotEmpty
              ? searchAttrs.primaryDetailColor
              : searchAttrs.secondaryDetailColor,
          onPressed: searchState.clearQueryCallback,
        ),
      ),
    );
  }

  double get _searchBarTotalHeight =>
      searchAttrs.searchBarSize.height + searchState.screenPadding.top;
}

class IconifiedBarBuilder extends SearchBarBuilder<IconifiedBarState> {
  IconifiedBarBuilder(IconifiedBarState state, BuildContext context)
      : super(state, context);

  @override
  Widget buildInactiveBar() {
    final actions = <Widget>[]..addAll(searchWidget.defaultBar.actions ?? []);
    searchWidget.searchItem
        .addSearchItem(searchContext, actions, searchState.onSearchAction);
    return _cloneDefaultBarWith(actions);
  }

  AppBar _cloneDefaultBarWith(List<Widget> actions) {
    final other = searchWidget.defaultBar;
    return AppBar(
      toolbarOpacity: other.toolbarOpacity,
      textTheme: other.textTheme,
      primary: other.primary,
      iconTheme: other.iconTheme,
      flexibleSpace: other.flexibleSpace,
      centerTitle: other.centerTitle,
      brightness: other.brightness,
      bottomOpacity: other.bottomOpacity,
      backgroundColor: other.backgroundColor,
      leading: other.leading,
      automaticallyImplyLeading: other.automaticallyImplyLeading,
      titleSpacing: other.titleSpacing,
      elevation: other.elevation,
      bottom: other.bottom,
      key: other.key,
      title: other.title,
      actions: actions,
    );
  }
}

class MergedBarBuilder extends SearchBarBuilder<MergedBarState> {
  MergedBarBuilder(MergedBarState searchState, BuildContext searchContext)
      : super(searchState, searchContext);

  @override
  Widget buildInactiveBar() {
    return buildBaseBar(
      leading: searchWidget.defaultBar.leading ??
          _buildScaffoldDefaultLeading(searchContext),
      search: buildSearchStackContainer(),
      actions: searchWidget.defaultBar.actions ?? [],
    );
  }

  Widget _buildScaffoldDefaultLeading(BuildContext context) {
    final scaffold = Scaffold.of(context);
    final hasDrawer = scaffold?.hasDrawer ?? false;
    final parentRoute = ModalRoute.of(context);
    final canPop = parentRoute?.canPop ?? false;
    final useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    if (hasDrawer) {
      return IconButton(
        icon: Icon(Icons.menu),
        onPressed: scaffold.openDrawer,
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    } else if (canPop) {
      return useCloseButton ? CloseButton() : BackButton();
    } else {
      return null;
    }
  }
}
