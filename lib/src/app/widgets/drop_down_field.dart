library dropdownfield;

import 'package:b2s_driver/src/app/service/common-service.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/ts24_utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///DropDownField has customized autocomplete text field functionality
///
///Parameters
///
///value - dynamic - Optional value to be set into the Dropdown field by default when this field renders
///
///icon - Widget - Optional icon to be shown to the left of the Dropdown field
///
///hintText - String - Optional Hint text to be shown
///
///hintStyle - TextStyle - Optional styling for Hint text. Default is normal, gray colored font of size 18.0
///
///labelText - String - Optional Label text to be shown
///
///labelStyle - TextStyle - Optional styling for Label text. Default is normal, gray colored font of size 18.0
///
///required - bool - True will validate that this field has a non-null/non-empty value. Default is false
///
///enabled - bool - False will disable the field. You can unset this to use the Dropdown field as a read only form field. Default is true
///
///items - List<dynamic> - List of items to be shown as suggestions in the Dropdown. Typically a list of String values.
///You can supply a static list of values or pass in a dynamic list using a FutureBuilder
///
///textStyle - TextStyle - Optional styling for text shown in the Dropdown. Default is bold, black colored font of size 14.0
///
///inputFormatters - List<TextInputFormatter> - Optional list of TextInputFormatter to format the text field
///
///setter - FormFieldSetter<dynamic> - Optional implementation of your setter method. Will be called internally by Form.save() method
///
///onValueChanged - ValueChanged<dynamic> - Optional implementation of code that needs to be executed when the value in the Dropdown
///field is changed
///
///strict - bool - True will validate if the value in this dropdown is amongst those suggestions listed.
///False will let user type in new values as well. Default is true
///
///itemsVisibleInDropdown - int - Number of suggestions to be shown by default in the Dropdown after which the list scrolls. Defaults to 3
class DropDownField extends FormField<String> {
  final dynamic value;
  final Widget icon;
  final String hintText;
  final TextStyle hintStyle;
  final String labelText;
  final String errorText;
  final TextStyle labelStyle;
  final TextStyle textStyle;
  final bool required;
  final bool enabled;
  final List<dynamic> items;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldSetter<dynamic> setter;
  final ValueChanged<dynamic> onValueChanged;
  final bool strict;
  final int itemsVisibleInDropdown;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController controller;
  DropDownField(
      {Key key,
      this.controller,
      this.value,
      this.required: false,
      this.icon,
      this.errorText,
      this.hintText,
      this.hintStyle: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 18.0),
      this.labelText,
      this.labelStyle: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 18.0),
      this.inputFormatters,
      this.items,
      this.textStyle: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15.0),
      this.setter,
      this.onValueChanged,
      this.itemsVisibleInDropdown: 4,
      this.enabled: true,
      this.strict: true})
      : super(
          key: key,
          autovalidate: false,
          initialValue: controller != null ? controller.text : (value ?? ''),
          onSaved: setter,
          builder: (FormFieldState<String> field) {
            final DropDownFieldState state = field;
            final ScrollController _scrollController = ScrollController();
            final InputDecoration effectiveDecoration = InputDecoration(
                focusColor: ThemePrimary.primaryColor,
                filled: false,
                icon: icon,
                errorText: errorText,
                suffixIcon: IconButton(
                    icon: Icon(
                        state._showdropdown
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        size: 30.0,
                        color: Colors.black54),
                    onPressed: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      state.setState(() {
                        state._showdropdown = !state._showdropdown;
                        print(state._showdropdown.toString());
                        state.changeController();
                      });
                    }),
                hintStyle: hintStyle,
                labelStyle: labelStyle,
                hintText: hintText,
                labelText: labelText);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        autovalidate: true,
                        controller: state._effectiveController,
                        decoration: effectiveDecoration.copyWith(
                            errorText: field.errorText),
                        style: textStyle,
                        textAlign: TextAlign.start,
                        autofocus: false,
                        obscureText: false,
                        maxLengthEnforced: true,
                        maxLines: 1,
                        validator: (String newValue) {
                          if (required) {
                            if (newValue == null || newValue.isEmpty)
                              return 'This field cannot be empty!';
                          }

                          //Items null check added since there could be an initial brief period of time
                          //when the dropdown items will not have been loaded

                          return null;
                        },
                        onSaved: setter,
                        enabled: enabled,
                        inputFormatters: inputFormatters,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 20,
                      ),
                      onPressed: () {
                        if (!enabled) return;
                        state._showdropdown = false;
                        print(state._showdropdown.toString());
                        state._isSearching = true;
                        state.clearValue();
                        state.changeController();
                      },
                    )
                  ],
                ),
                !state._showdropdown
                    ? Transform.scale(
                        scale: 1.0 - state._animationValue,
                        alignment: Alignment.topLeft,
                        child: Container(
                            margin: EdgeInsets.only(right: 50),
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 15.0),
                                  blurRadius: 15.0),
                            ]),
                            alignment: Alignment.topCenter,
                            height: itemsVisibleInDropdown *
                                55.0 *
                                state
                                    ._animationValue, //limit to default 3 items in dropdownlist view and then remaining scrolls
                            width: MediaQuery.of(state.context).size.width,
                            child: items.isNotEmpty
                                ? ListView(
                                    cacheExtent: 0.0,
                                    scrollDirection: Axis.vertical,
                                    controller: _scrollController,
                                    padding: EdgeInsets.only(left: 0.0),
                                    children: items.isNotEmpty
                                        ? ListTile.divideTiles(
                                                context: state.context,
                                                tiles:
                                                    state._getChildren(items))
                                            .toList()
                                        : List(),
                                  )
                                : Center(
                                    child: LoadingSpinner.loadingView(
                                      context: state.context,
                                      loading: items.isEmpty,
                                    ),
                                  )),
                      )
                    : Transform.scale(
                        scale: state._animationValue,
                        alignment: Alignment.topLeft,
                        child: Container(
//                    margin: EdgeInsets.only(right: 50),
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 15.0),
                                  blurRadius: 15.0),
                            ]),
                            alignment: Alignment.topCenter,
                            height: itemsVisibleInDropdown *
                                55.0 *
                                state
                                    ._animationValue, //limit to default 3 items in dropdownlist view and then remaining scrolls
                            width: MediaQuery.of(state.context).size.width,
                            child: items.isNotEmpty
                                ? ListView(
                                    cacheExtent: 0.0,
                                    scrollDirection: Axis.vertical,
                                    controller: _scrollController,
                                    padding: EdgeInsets.only(left: 0.0),
                                    children: items.isNotEmpty
                                        ? ListTile.divideTiles(
                                                context: state.context,
                                                tiles:
                                                    state._getChildren(items))
                                            .toList()
                                        : List(),
                                  )
                                : Center(
                                    child: LoadingSpinner.loadingView(
                                      context: state.context,
                                      loading: items.isEmpty,
                                    ),
                                  )),
                      ),
              ],
            );
          },
        );

  @override
  DropDownFieldState createState() => DropDownFieldState();
}

class DropDownFieldState extends FormFieldState<String>
    with SingleTickerProviderStateMixin {
  TextEditingController _controller;
  bool _showdropdown = false;
  bool _isSearching = true;
  String _searchText = "";
  var _animationValue = 0.0;

  AnimationController _controllerA;
  CurvedAnimation _curvedAnimation;
  Animation<double> _animation;

  @override
  DropDownField get widget => super.widget;
  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;
  List<dynamic> get _items => widget.items;

  void toggleDropDownVisibility() {}
  void clearValue() {
    setState(() {
      _effectiveController.text = '';
    });
  }

  void changeController() {
    setState(() {
      if (_showdropdown)
        _controllerA.forward();
      else
        _controllerA.reverse();
    });
  }

  @override
  void didUpdateWidget(DropDownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            TextEditingController.fromValue(oldWidget.controller.value);
      if (widget.controller != null) {
        setValue(widget.controller.text);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _controllerA.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    }

    _effectiveController.addListener(_handleControllerChanged);

    _searchText = _effectiveController.text;
    _controllerA = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _curvedAnimation =
        CurvedAnimation(parent: _controllerA, curve: Curves.easeIn);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_curvedAnimation)
      ..addListener(() {
        _animationValue = _animation.value;
      });
    _controllerA.addListener(() {
      setState(() {
        _animationValue = _animation.value;
      });
    });
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue;
    });
  }

  List<ListTile> _getChildren(List<dynamic> items) {
    List<ListTile> childItems = List();
    for (var item in items) childItems.add(_getListTile(item));
    for (var item in items) {
      if (_searchText.isNotEmpty) {
        if (Common.sanitizing(item.displayName
            .toUpperCase())
            .contains(Common.sanitizing(_searchText.toUpperCase()))) {
          ListTile title = _getListTile(item);
          childItems.removeAt(items.indexOf(item));
          childItems.insert(0, title);
        }
//      } else {
//        childItems.add(_getListTile(item));
      }
    }
    _isSearching ? childItems : List();
    return childItems;
  }

  ListTile _getListTile(dynamic item) {
    return ListTile(
      dense: true,
      title: Text(
        item.displayName,
      ),
      onTap: () {
        setState(() {
          _effectiveController.text = item.displayName;
          _handleControllerChanged();
          _showdropdown = false;
          _isSearching = false;
          _controllerA.reverse();
          if (widget.onValueChanged != null) widget.onValueChanged(item);
        });
      },
    );
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value)
      didChange(_effectiveController.text);

    if (_effectiveController.text.isEmpty) {
      setState(() {
        _isSearching = false;
        _showdropdown = false;
        _searchText = "";
        _controllerA.reverse();
      });
    } else {
      setState(() {
        _isSearching = true;
        _searchText = _effectiveController.text;
        _showdropdown = true;
        _controllerA.forward();
      });
    }
  }
}

class ItemDropDownField {
  int id;
  String displayName;
  ItemDropDownField({this.id, this.displayName});
}
