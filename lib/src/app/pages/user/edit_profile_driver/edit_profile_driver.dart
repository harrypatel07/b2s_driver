import 'dart:io';

import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/pages/user/edit_profile_driver/edit_profile_driver_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/drop_down_field.dart';
import 'package:b2s_driver/src/app/widgets/ts24_utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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
      viewModel.nameEditingController.text = widget.driver.name;
      viewModel.phoneEditingController.text = widget.driver.phone;
//      viewModel.emailEditingController.text = widget.driver.email;
//      viewModel.addressEditingController.text = widget.driver.contactAddress;
      viewModel.genderEditingController.text = widget.driver.gender.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    viewModel.context = context;
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
              ? AssetImage('assets/images/user.png')
              : (viewModel.driver != null && viewModel.imagePicker == null
                  ? (viewModel.driver.photo == null
                      ? AssetImage('assets/images/user.png')
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

    final cancelBtn = Positioned(
      top: 25.0,
      left: 0.0,
      child: Container(
        height: 50.0,
        width: 70.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey.withOpacity(0.5),
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
          iconSize: 20.0,
        ),
      ),
    );
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
                        controller: viewModel.nameEditingController,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Họ và tên',
                          hintText:
                              driver != null ? driver.name : "Nhập tên...",
                          errorText: viewModel.errorName,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (v) {},
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
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: DropDownField(
                              controller: viewModel.genderEditingController,
                              itemsVisibleInDropdown: 3,
                              value: viewModel.gender,
                              labelText: 'Giới tính',
                              items: viewModel.listGender,
//                                setter: (dynamic value){
//                                  viewModel.gender = value;
//                                },
                              onValueChanged: (v) {
                                viewModel.gender = v;
                                viewModel.genderEditingController.text =
                                    v.displayName;
                              },
                            ),
                          ),
                        ],
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
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: viewModel.phoneEditingController,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Số điện thoại',
                          hintText: driver != null
                              ? driver.phone.toString()
                              : "Nhập số điện thoại",
                          errorText: viewModel.errorPhone,
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
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
                          child: Stack(
                            children: <Widget>[
                              _avatar(),
                              cancelBtn,
                            ],
                          ),
                        ),
                        _card(viewModel.driver),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
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
                                      LoadingDialog.hideLoadingDialog(context);
                                      Navigator.pop(context);
                                    } else {
                                      LoadingDialog.hideLoadingDialog(context);
                                      Navigator.pop(context);
                                    }
                                  });
                                },
                                child: Center(
                                  child: Text("LƯU",style: TextStyle(color: Colors.white),),
                                )),
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

class Consts {
  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
