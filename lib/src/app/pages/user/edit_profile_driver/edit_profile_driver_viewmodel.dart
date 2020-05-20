import 'dart:io';
import 'dart:typed_data';

import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/helper/utils.dart';
import 'package:b2s_driver/src/app/helper/validator-helper.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/res-partner.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileDriverViewModel extends ViewModelBase {
  Driver driver;
  TextEditingController _nameEditingController = new TextEditingController();
  TextEditingController get nameEditingController => _nameEditingController;
//  TextEditingController _emailEditingController = new TextEditingController();
//  TextEditingController get emailEditingController => _emailEditingController;
  TextEditingController _phoneEditingController = new TextEditingController();
  TextEditingController get phoneEditingController => _phoneEditingController;
//  TextEditingController _addressEditingController = new TextEditingController();
//  TextEditingController get addressEditingController =>
//      _addressEditingController;
  TextEditingController _genderEditingController = new TextEditingController();
  TextEditingController get genderEditingController => _genderEditingController;
  List<ItemDropDownField> listGender = List();
  Uint8List imagePicker;
  String errorName;
  String _errorEmail;
  String errorGender;
  ItemDropDownField gender;
  get errorEmail => _errorEmail;
  String _errorPhone;
  get errorPhone => _errorPhone;
  String _errorAddress;
  get errorAdress => _errorAddress;
  File imageFile;
  dynamic pickImageError;
  String retrieveDataError;
  bool loadingGender = true;
  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  EditProfileDriverViewModel() {
    createEvent();
    getListGender();
  }
  createEvent() {
    _nameEditingController.addListener(() => {isValidName()});
//    _emailEditingController.addListener(() => {isValidEmail()});
    _phoneEditingController.addListener(() => {isValidPhone()});
//    _addressEditingController.addListener(() => {isValidAddress()});
  }

//  bool isValidEmail() {
//    _errorEmail = null;
//    var resultemail = Validator.validateEmail(_emailEditingController.text);
//    if (resultemail != null) {
//      _errorEmail = resultemail;
//      this.updateState();
//      return false;
//    } else
//      this.updateState();
//    return true;
//  }

  bool isValidPhone() {
    _errorPhone = null;
    var resultPhone = Validator.validatePhone(_phoneEditingController.text);
    if (resultPhone != null) {
      _errorPhone = resultPhone;
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  bool isValidName() {
    errorName = null;
    var resultName = Validator.validateName(_nameEditingController.text);
    if (resultName != null) {
      errorName = resultName.toString();
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

//  bool isValidAddress() {
//    _errorAddress = null;
//    var result = Validator.validAddress(_addressEditingController.text);
//    if (result != null) {
//      _errorAddress = result;
//      this.updateState();
//      return false;
//    } else
//      this.updateState();
//    return true;
//  }
  bool isValidGender() {
    errorGender = null;
    if (gender != null && gender.id != -1) {
      this.updateState();
      return true;
    } else {
      errorGender = "Giới tính không đúng.";
      this.updateState();
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameEditingController.dispose();
    _phoneEditingController.dispose();
//    _emailEditingController.dispose();
//    _addressEditingController.dispose();
  }

  bool isValidInfo() {
    if (isValidName() &&
        isValidPhone() /* && isValidEmail() && isValidAddress()*/) {
      this.updateState();
      return true;
    }
    return false;
//  return true;
  }

  updateDriver(Driver driver) {
    if (driver.name != _nameEditingController.text)
      driver.name = _nameEditingController.text;
//    if (driver.contactAddress != _addressEditingController.text)
//      driver.contactAddress = _addressEditingController.text;
    if (driver.phone != _phoneEditingController.text)
      driver.phone = _phoneEditingController.text;
//    if (driver.email != _emailEditingController.text)
//      driver.email = _emailEditingController.text;
    if (gender != null && gender.id != -1) {
      driver.genderId = gender.id;
      driver.photo = imagePicker;
      driver.gender = gender.displayName;
      errorGender = null;
    } else {
      errorGender = 'Giới tính không đúng.';
      this.updateState();
    }
  }

  Future<bool> saveDriver(Driver driver) async {
    print("save profile Parent");
    //this.updateState();
    if (isValidInfo() && isValidGender()) {
      if (driver != null) {
        if (_nameEditingController.text != "") {
          Driver _driver = Driver();
          updateDriver(_driver);
          bool result = await updateDriverSever(_driver);
          if (result) {
            driver = _driver;
            driver.photo =
                '$domainApi/web/image?model=res.partner&field=image&id=${driver.id}&${api.sessionId}';
            api.getDriverInfo(driver.id);
            return true;
          }
        }
      }
    }
    return false;
  }

  Future<bool> updateDriverSever(Driver driver) async {
    ResPartner resPartner = ResPartner.fromDriver(driver);
    bool result = await api.updateCustomer(resPartner);
    if (result) {
      driver.photo =
          '$domainApi/web/image?model=res.partner&field=image&id=${driver.id}&${api.sessionId}';
      api.getParentInfo(driver.id);
      return true;
    }
    return false;
  }

  onTapPickMaps() async {
//    LocationResult result = await LocationPicker.pickLocation(
//      context,
//      ggKey,
//    );
//    print("result = $result");
//    _addressEditingController.text = result.address;
//    this.updateState();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file == null) {
      imageFile = response.file;
      this.updateState();
    }
  }

  void onImageButtonPressed(ImageSource source) async {
    try {
      imageFile = await ImagePicker.pickImage(source: source);
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
//          CropAspectRatioPreset.ratio3x2,
//          CropAspectRatioPreset.original,
//          CropAspectRatioPreset.ratio4x3,
//          CropAspectRatioPreset.ratio16x9
              ]
            : [
//          CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
//          CropAspectRatioPreset.ratio3x2,
//          CropAspectRatioPreset.ratio4x3,
//          CropAspectRatioPreset.ratio5x3,
//          CropAspectRatioPreset.ratio5x4,
//          CropAspectRatioPreset.ratio7x5,
//          CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Chỉnh sửa ảnh',
            toolbarColor: ThemePrimary.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
      );
      if (croppedFile != null) {
        imageFile = croppedFile;
      }
      readFileByte(imageFile.path).then((bytesData) {
        imagePicker = bytesData;
        this.updateState();
      });
    } catch (e) {
      pickImageError = e;
    }
  }

  getListGender() {
    loadingGender = true;
    api.getTitleCustomer().then((lst) {
      lst.forEach((item) {
        listGender
            .add(ItemDropDownField(id: item.id, displayName: item.displayName));
      });
      listGender.insert(
          0, ItemDropDownField(id: -1, displayName: 'Chọn giới tính...'));
      if (driver.genderId != null)
        gender = getGenderFromID(driver.genderId);
      else
        gender = listGender[0];
      loadingGender = false;
      this.updateState();
    });
  }

  ItemDropDownField getGenderFromID(int id) {
    for (int i = 0; i < listGender.length; i++)
      if (listGender[i].id == id) return listGender[i];
    return listGender[0];
  }
}
