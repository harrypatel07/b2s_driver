import 'dart:io';

import 'package:b2s_driver/packages/flutter_form_builder/lib/src/fields/form_builder_dropdown.dart';
import 'package:b2s_driver/packages/flutter_form_builder/lib/src/form_builder_validators.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/pages/user/edit_profile_driver/edit_profile_driver_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/drop_down_field.dart';
import 'package:b2s_driver/src/app/widgets/ts24_button_widget.dart';
import 'package:b2s_driver/src/app/widgets/ts24_utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validators/sanitizers.dart';

class EditProfileDriver extends StatefulWidget {
  static const String routeName = "/editProfileDriver";
  final Driver driver;

  const EditProfileDriver({Key key, this.driver}) : super(key: key);
  @override
  _EditProfileDriverState createState() => _EditProfileDriverState();
}

class _EditProfileDriverState extends State<EditProfileDriver> {
  EditProfileDriverViewModel viewModel = EditProfileDriverViewModel();
  @override
  void initState() {
    // TODO: implement initState
    viewModel.driver = widget.driver;
    //viewModel.imagePicker = widget.driver.photo;
    if (widget.driver != null) {
      viewModel.nameEditingController.text = widget.driver.name.toString();
      viewModel.phoneEditingController.text =
          (toBoolean(widget.driver.phone.toString()) == false)
              ? ''
              : widget.driver.phone.toString();
//      viewModel.emailEditingController.text = widget.driver.email;
//      viewModel.addressEditingController.text = widget.driver.contactAddress;
      viewModel.genderEditingController.text =
          (widget.driver.gender == null) ? '' : widget.driver.gender.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    viewModel.context = context;
//    viewModel.driver.photo = null;
    Widget _avatar() {
      Widget _initImage() {
        // return Image(
        //   image: viewModel.driver == null
        //       ? AssetImage('assets/images/user.png')
        //       : MemoryImage(viewModel.imagePicker),
        //   fit: BoxFit.cover,
        // );
        return Image(
          image: (viewModel.driver == null && viewModel.imagePicker == null)
              ? AssetImage('assets/images/user-default.jpeg')
              : (viewModel.driver != null && viewModel.imagePicker == null
                  ? (viewModel.driver.photo == null
                      ? AssetImage('assets/images/user-default.jpeg')
                      : NetworkImage(viewModel.driver.photo))
                  : MemoryImage(viewModel.imagePicker)),
          fit: BoxFit.cover,
        );
      }

      Widget _resultImage() {
        final Text retrieveError = _getRetrieveErrorWidget();
        if (retrieveError != null) {
          return retrieveError;
        }
        if (viewModel.imageFile != null) {
          return Image(
            image: MemoryImage(viewModel.imagePicker),
            fit: BoxFit.cover,
          );
        } else if (viewModel.pickImageError != null) {
          return Text(
            'Pick image error: $viewModel.pickImageError',
            textAlign: TextAlign.center,
          );
        } else {
          return _initImage();
        }
      }

      final __editBtn = Positioned(
        bottom: 5.0,
        right: 5,
        child: Container(
          height: 70.0,
          width: 70.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.2),
          ),
          child: IconButton(
            icon: Icon(Icons.edit, size: 30, color: Colors.white),
            onPressed: () =>
                viewModel.onImageButtonPressed(ImageSource.gallery),
            iconSize: 20.0,
          ),
        ),
      );
      return Stack(
        children: <Widget>[
          Container(
            height: 350,
            width: MediaQuery.of(context).size.width,
            child: Platform.isAndroid
                ? FutureBuilder<void>(
                    future: viewModel.retrieveLostData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return _initImage();
                        case ConnectionState.done:
                          return _resultImage();
                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Pick image/video error: ${snapshot.error}}',
                                textAlign: TextAlign.center,
                              ),
                            );
                          } else {
                            return _initImage();
                          }
                      }
                    },
                  )
                : (_resultImage()),
          ),
          __editBtn,
        ],
      );
    }

    final __styleTextLabel = TextStyle(
        color: ThemePrimary.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 16);
    Widget _textFormFieldLoading(String text) {
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 45,
                ),
                Text(
                  text,
                  style: __styleTextLabel,
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        ThemePrimary.primaryColor),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Colors.grey[350],
            ),
          ],
        ),
      );
    }

    Widget _backButton() {
      return Positioned(
        top: 0,
        left: 0,
        child: SafeArea(
          bottom: false,
          top: true,
          child: TS24Button(
            onTap: () {
              Navigator.of(context).pop();
            },
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  topRight: Radius.circular(25)),
              color: Colors.black38,
            ),
            width: 70,
            height: 50,
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    Widget _card(Driver driver) {
      return Container(
        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        focusNode: viewModel.nameFocus,
                        controller: viewModel.nameEditingController,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Họ và tên',
                          labelStyle: __styleTextLabel,
                          hintText:
                              driver != null ? driver.name : "Nhập tên...",
                          errorText: viewModel.errorName,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (v) {
                          viewModel.fieldFocusChange(context,
                              viewModel.nameFocus, viewModel.phoneFocus);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: viewModel.loadingGender ||
                            viewModel.listGender.length == 0
                        ? _textFormFieldLoading('Giới tính')
                        : FormBuilderDropdown(
                            attribute: 'Giới tính',
                            decoration: InputDecoration(
                              errorText: viewModel.errorGender,
                              labelText: 'Giới tính',
                              labelStyle: __styleTextLabel,
                            ),
                            initialValue: viewModel.gender,
                            validators: [FormBuilderValidators.required()],
                            items: viewModel.listGender
                                .map((gender) =>
                                    DropdownMenuItem<ItemDropDownField>(
                                      value: gender,
                                      child: Text(gender.displayName),
                                    ))
                                .toList(),
                            onChanged: (gender) => viewModel.gender = gender,
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        focusNode: viewModel.phoneFocus,
                        controller: viewModel.phoneEditingController,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Số điện thoại',
                          labelStyle: __styleTextLabel,
                          hintText: "Nhập số điện thoại",
                          errorText: viewModel.errorPhone,
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (v) {
                          LoadingDialog.showLoadingDialog(
                              context, 'Đang xử lý...');
                          viewModel.saveDriver(viewModel.driver).then((v) {
                            if (v) {
                              LoadingDialog.hideLoadingDialog(context);
                              Navigator.pop(context);
                            } else {
                              LoadingDialog.hideLoadingDialog(context);
                              Navigator.pop(context);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
//            SizedBox(height: 15.0),
//            Container(
//              width: MediaQuery.of(context).size.width,
//              child: Row(
//                children: <Widget>[
//                  Flexible(
//                    child: Align(
//                      alignment: Alignment.center,
//                      child: TextFormField(
//                        controller: viewModel.emailEditingController,
//                        decoration: InputDecoration(
//                            labelText: 'Email',
//                            hintText:
//                                driver != null ? driver.email : "Nhập email...",
//                            errorText: viewModel.errorEmail),
//                        textInputAction: TextInputAction.next,
//                        keyboardType: TextInputType.text,
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            SizedBox(height: 15.0),
//            Container(
//              width: MediaQuery.of(context).size.width,
//              child: Row(
//                children: <Widget>[
//                  Flexible(
//                    flex: 4,
//                    child: Align(
//                      alignment: Alignment.center,
//                      child: TextFormField(
//                        controller: viewModel.addressEditingController,
//                        decoration: InputDecoration(
//                            labelText: 'Địa chỉ',
//                            hintText: driver != null
//                                ? driver.contactAddress
//                                : "Địa chỉ...",
//                            errorText: viewModel.errorAdress),
//                        textInputAction: TextInputAction.done,
//                        keyboardType: TextInputType.text,
//                      ),
//                    ),
//                  ),
//                  Flexible(
//                    flex: 1,
//                    child: Align(
//                      alignment: Alignment.center,
//                      child: InkWell(
//                        onTap: () {
//                          viewModel.onTapPickMaps();
//                        },
//                        child: Container(
//                          width: 40,
//                          height: 40,
//                          child: Icon(
//                            FontAwesomeIcons.searchLocation,
//                            color: ThemePrimary.primaryColor,
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: ViewModelProvider(
        viewmodel: viewModel,
        child: StreamBuilder<Object>(
            stream: viewModel.stream,
            builder: (context, snapshot) {
              return Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: <Widget>[
                              _avatar(),
                              _backButton(),
                            ],
                          ),
                        ),
                        _card(viewModel.driver),
                        SizedBox(
                          height: 70,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      top: false,
                      bottom: true,
                      child: Container(
                        height: 50,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    ThemePrimary.primaryColor,
                                    ThemePrimary.primaryColor
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[500],
                                    offset: Offset(0.0, 1.5),
                                    blurRadius: 1.5,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  onTap: () async {
                                    LoadingDialog.showLoadingDialog(
                                        context, 'Đang xử lý...');
                                    viewModel
                                        .saveDriver(viewModel.driver)
                                        .then((v) {
                                      if (v) {
                                        LoadingDialog.hideLoadingDialog(
                                            context);
                                        Navigator.pop(context);
                                      } else {
                                        LoadingDialog.hideLoadingDialog(
                                            context);
//                                        Navigator.pop(context);
                                      }
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      "LƯU",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

  Text _getRetrieveErrorWidget() {
    if (viewModel.retrieveDataError != null) {
      final Text result = Text(viewModel.retrieveDataError);
      viewModel.retrieveDataError = null;
      return result;
    }
    return null;
  }
}

class Const {
  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
