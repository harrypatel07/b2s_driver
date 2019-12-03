import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/models/bottom_sheet_viewmodel_abstract.dart';
import 'package:b2s_driver/src/app/pages/attendant/attendant_page.dart';
import 'package:b2s_driver/src/app/service/barcode-service.dart';
import 'package:b2s_driver/src/app/widgets/ts24_utils_widget.dart';
import 'package:flutter/cupertino.dart';

class AttendantManagerViewModel extends BottomSheetViewModelBase {
  AttendantManagerViewModel();
  int countChildrenPickDrop(int routeBusId, int typePickDrop) {
    int count = 0;
    driverBusSession.childDrenStatus.forEach((status) {
      if (status.routeBusID == routeBusId &&
          status.typePickDrop == typePickDrop &&
          status.statusID != 3) count++;
    });
    return count;
  }

  onTapFinish() async {
    if (driverBusSession.totalChildrenPick ==
            driverBusSession.totalChildrenDrop &&
        (driverBusSession.totalChildrenPick +
                driverBusSession.totalChildrenLeave) ==
            driverBusSession.totalChildrenRegistered) {
      driverBusSession.status = true;
      loading = true;
      this.updateState();
      //Kiểm tra driver đã hoàn thành chuyến
      List<int> listIdPicking =
          driverBusSession.childDrenStatus.map((item) => item.id).toList();
      bool checkFinished =
          await checkSessionFinishedByAnotherRole(listIdPicking);
      loading = false;
      this.updateState();
      if (!checkFinished) {
        String barcode = await BarCodeService.scan();
        print(barcode);
        if (barcode != null) {
          driverBusSession.clearLocal();
          api.updateUserRoleFinishedBusSession(listIdPicking, 1);
        } else
          return false;
      }
      Navigator.pushReplacementNamed(context, AttendantPage.routeName);
    } else
      LoadingDialog.showMsgDialog(context,
          'Chưa hoàn thành tất cả các trạm, không thể kết thúc chuyến.');
  }

  Future<bool> checkSessionFinishedByAnotherRole(
      List<int> listIdPicking) async {
    //Kiểm tra attendant đã hoàn thành chuyến
    bool result = await api.checkUserRoleFinishedBusSession(listIdPicking);
    return result;
  }
}
