import 'package:b2s_driver/packages/loader_search_bar/loader_search_bar.dart';
import 'package:flutter/material.dart';

typedef T SearchItemBuilder<T>(BuildContext context);
typedef PopupMenuItem<T> MenuItemBuilder<T>(BuildContext context);

abstract class SearchItem<T> {
  SearchItem(SearchItemGravity gravity, this._builder)
      : this.gravity = gravity ?? SearchItemGravity.start;

  final SearchItemGravity gravity;
  final SearchItemBuilder<T> _builder;
  SearchItemBuilder<T> get builder => _builder ?? _defaultBuilder;

  SearchItemBuilder get _defaultBuilder;
  void addSearchItem(
      BuildContext context, List<Widget> actions, void onSearch());

  static action({SearchItemGravity gravity, WidgetBuilder builder}) =>
      _ActionSearchItem(gravity, builder);

  static menu<T>({SearchItemGravity gravity, MenuItemBuilder<T> builder}) =>
      _MenuSearchItem<T>(gravity, builder);
}

class _ActionSearchItem extends SearchItem<Widget> {
  _ActionSearchItem(
    SearchItemGravity gravity,
    SearchItemBuilder<Widget> builder,
  ) : super(gravity, builder);

  @override
  SearchItemBuilder get _defaultBuilder =>
      (_) => IconButton(icon: Icon(Icons.add), onPressed: () {
        print('LENGOCHIEP');
      });

  @override
  void addSearchItem(
      BuildContext context, List<Widget> actions, void onSearch()) {
    final item = InkWell(
      onTap: onSearch,
      child: AbsorbPointer(
        child: builder(context),
      ),
    );
    final index = gravity.getInsertPosition(actions);
    actions.insert(index, item);
  }
}

class _MenuSearchItem<T> extends SearchItem<PopupMenuItem<T>> {
  _MenuSearchItem(
    SearchItemGravity gravity,
    SearchItemBuilder<PopupMenuItem<T>> builder,
  ) : super(gravity, builder);

  @override
  SearchItemBuilder get _defaultBuilder =>
      (_) => PopupMenuItem<Object>(child: Text('Search'), value: Object());

  @override
  void addSearchItem(
      BuildContext context, List<Widget> actions, void onSearch()) {
    final menuIndex = actions.lastIndexWhere((it) => it is PopupMenuButton);
    final menu = menuIndex != -1
        ? actions[menuIndex]
        : PopupMenuButton(itemBuilder: (_) => []);
    final wrapperIndex = menuIndex != -1 ? menuIndex : actions.length;
    final menuWrapper = _wrapMenuWithSearchItem(menu, context, onSearch);
    actions
      ..remove(menu)
      ..insert(wrapperIndex, menuWrapper);
  }

  PopupMenuButton _wrapMenuWithSearchItem(
      PopupMenuButton menu, BuildContext context, void onSearch()) {
    final searchItem = builder(context);
    return PopupMenuButton(
      itemBuilder: (context) {
        final items = menu.itemBuilder(context);
        final searchIndex = gravity.getInsertPosition(items);
        return items..insert(searchIndex, searchItem);
      },
      onSelected: (value) {
        if (value == searchItem.value) {
          onSearch();
        } else {
          menu.onSelected(value);
        }
      },
    );
  }
}
