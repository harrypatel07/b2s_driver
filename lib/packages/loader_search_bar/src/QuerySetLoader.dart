import 'dart:async';

import 'package:b2s_driver/packages/loader_search_bar/src/StateHolder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'InheritedSearchWidget.dart';
import 'ListModel.dart';

typedef List<T> QuerySetCall<T>(String query);

typedef Widget QuerySetItemBuilder<T>(T item);

/// Widget that loads data set for current query string and transforms it into
/// ListView populated with loaded data.
class QuerySetLoader<T> extends StatefulWidget {
  QuerySetLoader({
    @required this.querySetCall,
    @required this.itemBuilder,
    this.loadOnEachChange = false,
    this.animateChanges = true,
  });

  /// Instance with empty function bodies used internally by [SearchBar].
  static final QuerySetLoader blank =
      QuerySetLoader(querySetCall: (_) {}, itemBuilder: (_) {});

  /// Function being called in order to load data. Takes query string as
  /// argument and returns list of corresponding items. Received function is
  /// called asynchronously within the loader.
  final QuerySetCall<T> querySetCall;

  /// Function taking single element of current data set and returning ListView
  /// item corresponding to that element.
  final QuerySetItemBuilder<T> itemBuilder;

  /// Indicating whether [querySetCall] should be triggered on each query
  /// change. If false query set is loaded once user submits query.
  final bool loadOnEachChange;

  /// Determines whether ListView's insert and remove operations should be
  /// animated.
  final bool animateChanges;

  /// Used internally by SearchBar to clear list data once user ends search action.
  void clearData() => QuerySetLoaderState._stateHolder[this]?.clearLoader();

  @override
  QuerySetLoaderState createState() => QuerySetLoaderState<T>();
}

class QuerySetLoaderState<T> extends State<QuerySetLoader<T>> {
  static final _stateHolder =
      StateHolder<QuerySetLoader, QuerySetLoaderState>();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  ListModel<T> _listModel;

  bool _isLoading = false;

  StreamSubscription<List<T>> _querySetStream;

  String _previousQuery;

  @override
  void initState() {
    super.initState();
    _stateHolder.add(this);
    _listModel = ListModel<T>(
      listKey: _listKey,
      initialItems: [],
      removedItemBuilder: _buildAnimatedItem,
      animationDuration: widget.animateChanges
          ? ListModel.DEFAULT_ANIM_DURATION
          : ListModel.NO_ANIM_DURATION,
    );
  }

  @override
  void dispose() {
    _stateHolder.remove(this);
    super.dispose();
  }

  void clearLoader() {
    _listModel.clear();
    _previousQuery = null;
  }

  void _loadDataIfQueryChanged(BuildContext context) {
    final currentQuery = InheritedSearchQuery.of(context);
    if (_previousQuery != currentQuery) {
      _cancelQuerySetLoad();
      _launchQuerySetLoad(context, currentQuery);
      _previousQuery = currentQuery;
    }
  }

  void _cancelQuerySetLoad() {
    if (_querySetStream != null) {
      _querySetStream.cancel();
    }
    _setLoadedState();
  }

  void _launchQuerySetLoad(BuildContext context, String query) {
    setState(() {
      _isLoading = true;
    });
    _querySetStream = _loadQuerySet(context, query)
        .asStream()
        .listen(_onQuerySetData, onError: _onQuerySetError);
  }

  Future<List<T>> _loadQuerySet(BuildContext context, String query) async {
    return query != null ? widget.querySetCall(query) : [];
  }

  void _onQuerySetData(List<T> data) {
    if (!_listModel.equals(data)) {
      _removeItems(data);
      _insertItems(data);
    }
    _setLoadedState();
  }

  void _removeItems(List<T> items) {
    final toRemove = _listModel.where((it) => !items.contains(it)).toList();
    toRemove.forEach((item) {
      final index = _listModel.indexOf(item);
      if (index != -1) _listModel.removeAt(index);
    });
  }

  void _insertItems(List<T> items) {
    final toInsert = items.where((it) => !_listModel.contains(it)).toList();
    toInsert.forEach((item) {
      final index = items.indexOf(item);
      if (index != -1) _listModel.insert(index, item);
    });
  }

  void _onQuerySetError(Object error) => _onQuerySetData([]);

  void _setLoadedState() {
    setState(() {
      _querySetStream = null;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadDataIfQueryChanged(context);
    return _buildListStack();
  }

  Widget _buildListStack() {
    final stack = Stack(
      children: [_buildAnimatedList()],
    );
    if (_isLoading) {
      stack.children.add(Container(
        color: Colors.transparent,
        child: Center(),
      ));
    }
    return stack;
  }

  Widget _buildAnimatedList() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Container(
        color: Colors.black12,
        child: AnimatedList(
          key: _listKey,
          itemBuilder: _buildListItem,
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index, Animation animation) =>
      _buildAnimatedItem(_listModel[index], context, animation);

  Widget _buildAnimatedItem(T item, BuildContext _, Animation animation) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        child: widget.itemBuilder(item),
      ),
    );
  }
}
