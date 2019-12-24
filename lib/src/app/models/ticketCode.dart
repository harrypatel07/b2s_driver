class TicketCode {
  String schoolType = "0"; // Loại trường: tiểu học, trung học
  String schoolId = "0000"; // Id trường: lấy theo company Id
  String dateInitCode = "000000"; // Ngày tạo mã :format yymmdd
  String classId = "000"; // Id lớp
  String birthDay = "0000"; // Ngày sinh user: format mmdd
  String childrenId = "00000"; //id children
  String numberCheck = "0"; // số kiểm tra
  String ticketCode = "";
  TicketCode(
      {this.schoolType,
      this.schoolId,
      this.dateInitCode,
      this.classId,
      this.birthDay,
      this.childrenId});

  generateCode({String code: ""}) {
    try {
      var ordinalNum = 0, A = 0, B = 0, C = 0, D = 0, M = 0, K = 0;
      var sumCode = code != ""
          ? code
          : this.schoolType +
              this.schoolId +
              this.dateInitCode +
              this.classId +
              this.birthDay +
              this.childrenId;

      this.schoolType = code.substring(0, 1);
      this.schoolType = code.substring(1, 5);
      this.schoolId = code.substring(5, 11);
      this.dateInitCode = code.substring(11, 14);
      this.classId = code.substring(11, 14);
      this.birthDay = code.substring(14, 18);
      this.childrenId = code.substring(18, 23);
      for (var index = 0; index < sumCode.length; index++) {
        ordinalNum = index + 1;
        switch (ordinalNum) {
          case 1:
          case 5:
          case 9:
          case 13:
          case 17:
          case 21:
            A += int.parse((sumCode[index]));
            break;
          case 2:
          case 6:
          case 10:
          case 14:
          case 18:
          case 22:
            B += int.parse((sumCode[index]));
            break;
          case 3:
          case 7:
          case 11:
          case 15:
          case 19:
          case 23:
            C += int.parse((sumCode[index]));
            break;
          case 4:
          case 8:
          case 12:
          case 16:
          case 20:
            D += int.parse((sumCode[index]));
            break;
        }
      }

      B = B * 3;
      C = C * 5;
      D = D * 7;
      M = (A + B + C + D) % 10;
      if (M == 0)
        K = 0;
      else if (M > 0) K = 10 - M;
      this.numberCheck = K.toString();
      this.ticketCode = sumCode + this.numberCheck;
    } catch (ex) {
      print(ex);
    }
  }

  bool checkTicketCode(String code) {
    if (code.length == 24) {
      var codeSubString = code.substring(0, code.length - 1);
      this.generateCode(code: codeSubString);
      if (code == this.ticketCode)
        return true;
      else
        return false;
    }
    return false;
  }
}
