import 'package:flutter/material.dart';

class InheritedSearchQuery extends InheritedWidget {
  InheritedSearchQuery({
    @required this.query,
    Widget child,
  }) : super(child: child);

  static String of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(InheritedSearchQuery)
              as InheritedSearchQuery)
          .query;

  final String query;

  @override
  bool updateShouldNotify(InheritedSearchQuery old) =>
      query != null && old.query != query;
}
