import 'package:b2s_driver/src/app/models/bottom_sheet_viewmodel_abstract.dart';
import 'package:b2s_driver/src/app/pages/attendant/attendant_page.dart';
import 'package:b2s_driver/src/app/widgets/ts24_utils_widget.dart';
import 'package:flutter/cupertino.dart';

class AttendantManagerViewModel extends BottomSheetViewModelBase {
  AttendantManagerViewModel();
  int countChildrenPickDrop(int routeBusId, int typePickDrop) {
    int count = 0;
    driverBusSession.childDrenStatus.forEach((status) {
      if (status.routeBusID == routeBusId &&
          status.typePickDrop == typePickDrop && status.statusID != 3) count++;
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
//      String barcode = await BarCodeService.scan();
//      print(barcode);
//      if (barcode != null) {
//        driverBusSession.clearLocal();
        Navigator.pushReplacementNamed(context, AttendantPage.routeName);
//      }
    } else
      LoadingDialog.showMsgDialog(context,
          'Chưa hoàn thành tất cả các trạm, không thể kết thúc chuyến.');
  }
}
