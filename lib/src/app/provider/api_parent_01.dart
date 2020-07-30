import 'dart:convert';
import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/models/bodyNotification.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/childrenBusSession.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/fleet-vehicle.dart';
import 'package:b2s_driver/src/app/models/historyDriver.dart';
import 'package:b2s_driver/src/app/models/message.dart';
import 'package:b2s_driver/src/app/models/parent.dart';
import 'package:b2s_driver/src/app/models/picking-route.dart';
import 'package:b2s_driver/src/app/models/picking-transport-info.dart';
import 'package:b2s_driver/src/app/models/res-partner-title.dart';
import 'package:b2s_driver/src/app/models/res-partner.dart';
import 'package:b2s_driver/src/app/models/route-location.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/models/sale-order-line.dart';
import 'package:b2s_driver/src/app/models/sale-order.dart';
import 'package:b2s_driver/src/app/models/statusBus.dart';
import 'package:b2s_driver/src/app/service/index.dart';
import 'package:b2s_driver/src/app/service/onesingal-service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import 'api_master.dart';

enum TypeImage {
  SMALL,
  MEDIUM,
  ORIGINAL,
}

class Api1 extends ApiMaster {
  Api1();

  ///Kiểm tra thông tin đăng nhập.
  ///Trả về true or false.
  Future<StatusCodeGetToken> checkLogin(
      {String username, String password}) async {
    StatusCodeGetToken result = StatusCodeGetToken.FALSE;
    this.grandType = GrandType.password;
    this.clientId = password_client_id;
    this.clienSecret = password_client_secret;
    this.username = username;
    this.password = password;
    result = await this.authorization(refresh: true);
    return result;
  }

  ///Kiểm tra partner id có phải là driver
  Future<bool> checkIsDriver(int id) async {
    await this.authorization();
    body = new Map();
    body["domain"] = [
      ['driver_id', '=', id]
    ];
    body["fields"] = [
      "name",
      "id",
      "x_posx",
      "x_posy",
      "x_posz",
      "license_plate",
      "x_qr_code"
    ];
    var params = convertSerialize(body);
    return http
        .get('${this.api}/search_read/fleet.vehicle?$params',
            headers: this.headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0) {
          List<FleetVehicle> listFleetVehicle =
              list.map((item) => FleetVehicle.fromJson(item)).toList();
          Driver driver = Driver();
          driver.listVehicle = listFleetVehicle;
          driver.vehicleId = listFleetVehicle[0].id;
          driver.vehicleName = listFleetVehicle[0].licensePlate;
          driver.vehicleNameTracCar = listFleetVehicle[0].name;
          driver.isDriver = true;
          await driver.saveLocal();
          return true;
        }
      }
      return false;
    }).catchError((error) {
      return false;
    });
  }

  ///Kiểm tra partner id có phải là attendant
  Future<bool> checkIsAttendant(int id) async {
    await this.authorization();
    body = new Map();
    body["domain"] = [
      ['x_manager_shuttle', '=', id]
    ];
    body["fields"] = [
      "name",
      "id",
      "x_posx",
      "x_posy",
      "x_posz",
      "driver_id",
      "license_plate",
      "x_qr_code"
    ];
    var params = convertSerialize(body);
    return http
        .get('${this.api}/search_read/fleet.vehicle?$params',
            headers: this.headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0) {
          List<FleetVehicle> listFleetVehicle =
              list.map((item) => FleetVehicle.fromJson(item)).toList();
          Driver driver = Driver();
          driver.listVehicle = listFleetVehicle;
          driver.vehicleId = listFleetVehicle[0].id;
          driver.vehicleName = listFleetVehicle[0].licensePlate;
          driver.vehicleNameTracCar = listFleetVehicle[0].name;
          driver.isDriver = false;
          driver.driverId = listFleetVehicle[0].driverId[0];
          await driver.saveLocal();
          return true;
        }
      }
      return false;
    }).catchError((error) {
      return false;
    });
  }

  ///Hàm thay đổi driverId vào model Driver khi chọn vehicle cho attendent
  Future<bool> changeDriverByVehicle(int vehicleId) async {
    await this.authorization();
    body = new Map();
    body["domain"] = [
      ['id', '=', vehicleId]
    ];
    body["fields"] = [
      "name",
      "id",
      "x_posx",
      "x_posy",
      "x_posz",
      "driver_id",
      "license_plate",
      "x_qr_code"
    ];
    var params = convertSerialize(body);
    return http
        .get('${this.api}/search_read/fleet.vehicle?$params',
            headers: this.headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0) {
          List<FleetVehicle> listFleetVehicle =
              list.map((item) => FleetVehicle.fromJson(item)).toList();
          Driver driver = Driver();
          driver.vehicleId = listFleetVehicle[0].id;
          driver.vehicleName = listFleetVehicle[0].licensePlate;
          driver.vehicleNameTracCar = listFleetVehicle[0].name;
          driver.isDriver = false;
          driver.driverId = listFleetVehicle[0].driverId[0];
          await driver.saveLocal();
          return true;
        }
      }
      return false;
    }).catchError((error) {
      return false;
    });
  }

  ///Lấy thông tin driver
  Future<Driver> getDriverInfo(int id) async {
    await this.authorization();
    body = new Map();
    body["domain"] = [
      ['id', '=', id],
    ];
    body["fields"] = [
      "company_id",
      "company_name",
      "company_type",
      "contact_address",
      "contract_ids",
      "contracts_count",
      "country_id",
      "create_date",
      "create_uid",
      "credit",
      "credit_limit",
      "currency_id",
      "customer",
      "date",
      "debit",
      "debit_limit",
      "display_name",
      "email",
      "email_formatted",
      "employee",
      "id",
      "im_status",
      "is_company",
      "is_published",
      "is_seo_optimized",
      "journal_item_count",
      "lang",
      "mobile",
      "name",
      "parent_id",
      "parent_name",
      "partner_gid",
      "partner_share",
      "phone",
      "state_id",
      "street",
      "street2",
      "supplier",
      "team_id",
      "title",
      "total_invoiced",
      "trust",
      "type",
      "user_id",
      "user_ids",
      "vat",
      "vehicle_count",
      "vehicle_ids",
      "x_class",
      "x_company_type",
      "x_date_of_birth",
      "x_school",
      "wk_dob"
    ];
    var params = convertSerialize(body);
    Driver driver = Driver();
    return http
        .get('${this.api}/search_read/res.partner?$params',
            headers: this.headers)
        .then((http.Response response) async {
      this.updateCookie(response);
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0) {
          ResPartner resPartner = ResPartner.fromJson(list[0]);
          driver.fromResPartner(resPartner);
          //kiem tra quyen pickdrop
          driver.checkPickDrop = await this.checkPermissionPickDropByEmail();
          driver.saveLocal();
        }
      }
      return driver;
    }).catchError((error) {
      return driver;
    });
  }

  /// Lấy thông tin Parent và children
  ///
  Future<List<ResPartner>> getParentInfo(int id) async {
    await this.authorization();
    body = new Map();
    body["domain"] = [
      '|',
      ['id', '=', id],
      ['parent_id', '=', id]
    ];
    var params = convertSerialize(body);
    List<ResPartner> listResult = new List();
    return http
        .get('${this.api}/search_read/res.partner?$params',
            headers: this.headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0)
          listResult = list.map((item) => ResPartner.fromJson(item)).toList();
        final parent = listResult.firstWhere((item) => item.id == id);
        final children = listResult.where((item) {
          if (item.parentId is List) {
            final List listParent = item.parentId;
            return listParent[0] == id;
          }
          return false;
        }).toList();
        Parent parentInfo = Parent();
        parentInfo.fromResPartner(parent, children);
        await parentInfo.saveLocal();
      }
      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  ///Lấy thông tin khách hàng
  Future<ResPartner> getCustomerInfo(String id) async {
    await this.authorization();
    body = new Map();
    body["domain"] = [
      ['id', '=', id],
    ];
    body["fields"] = [
      "company_id",
      "company_name",
      "company_type",
      "contact_address",
      "contract_ids",
      "contracts_count",
      "country_id",
      "create_date",
      "create_uid",
      "credit",
      "credit_limit",
      "currency_id",
      "customer",
      "date",
      "debit",
      "debit_limit",
      "display_name",
      "email",
      "email_formatted",
      "employee",
      "id",
      "im_status",
      "is_company",
      "is_published",
      "is_seo_optimized",
      "journal_item_count",
      "lang",
      "mobile",
      "name",
      "parent_id",
      "parent_name",
      "partner_gid",
      "partner_share",
      "phone",
      "state_id",
      "street",
      "street2",
      "supplier",
      "team_id",
      "title",
      "total_invoiced",
      "trust",
      "type",
      "user_id",
      "user_ids",
      "vat",
      "vehicle_count",
      "vehicle_ids",
      "x_class",
      "x_company_type",
      "x_date_of_birth",
      "x_school",
      "wk_dob"
    ];
    var params = convertSerialize(body);
    List<ResPartner> listResult = new List();
    return http
        .get('${this.api}/search_read/res.partner?$params',
            headers: this.headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0)
          listResult = list.map((item) => ResPartner.fromJson(item)).toList();
      }
      return listResult[0];
    }).catchError((error) {
      return null;
    });
  }

  ///Lấy thông tin title(gender) của khách hàng
  Future<List<ResPartnerTitle>> getTitleCustomer() async {
    await this.authorization();
    List<ResPartnerTitle> listResult = new List();
    return http
        .get('${this.api}/search_read/res.partner.title', headers: this.headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0)
          listResult =
              list.map((item) => ResPartnerTitle.fromJson(item)).toList();
      }
      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  ///Lấy danh sách trường học
  Future<List<ResPartner>> getListSchool() async {
    await this.authorization();
    List<ResPartner> listResult = new List();
    body = new Map();
    body["domain"] = [
      ['is_company', '=', true],
    ];
    var params = convertSerialize(body);
    return http
        .get('${this.api}/search_read/res.partner?$params',
            headers: this.headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0)
          listResult = list.map((item) => ResPartner.fromJson(item)).toList();
      }
      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  ///Lấy danh sách contact for user to chat
  Future<List<ResPartner>> getListContact() async {
    await this.authorization();
    body = new Map();
    body["fields"] = [
      "additional_info",
      "bank_account_count",
      "bank_ids",
      "barcode",
      "calendar_last_notif_ack",
      "category_id",
      "channel_ids",
      "child_ids",
      "city",
      "color",
      "comment",
      "commercial_company_name",
      "commercial_partner_id",
      "company_id",
      "company_name",
      "company_type",
      "contact_address",
      "contract_ids",
      "contracts_count",
      "country_id",
      "create_date",
      "create_uid",
      "credit",
      "credit_limit",
      "currency_id",
      "customer",
      "date",
      "debit",
      "debit_limit",
      "display_name",
      "email",
      "email_formatted",
      "employee",
      "event_count",
      "function",
      "has_unreconciled_entries",
      "id",
      "im_status",
      "industry_id",
      "is_blacklisted",
      "is_company",
      "is_published",
      "is_seo_optimized",
      "journal_item_count",
      "lang",
      "last_time_entries_checked",
      "last_website_so_id",
      "meeting_count",
      "meeting_ids",
      "mobile",
      "name",
      "opportunity_count",
      "opportunity_ids",
      "parent_id",
      "parent_name",
      "partner_gid",
      "partner_share",
      "payment_token_count",
      "payment_token_ids",
      "phone",
      "state_id",
      "street",
      "street2",
      "supplier",
      "team_id",
      "title",
      "total_invoiced",
      "trust",
      "type",
      "tz",
      "tz_offset",
      "user_id",
      "user_ids",
      "vat",
      "vehicle_count",
      "vehicle_ids",
      "x_class",
      "x_company_type",
      "x_date_of_birth",
      "x_school",
      "zip",
      "wk_dob"
    ];
    var params = convertSerialize(body);
    List<ResPartner> listResult = List();
    return http
        .get('${this.api}/search_read/res.partner?$params',
            headers: this.headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0)
          listResult = list.map((item) => ResPartner.fromJson(item)).toList();
      }
      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  /// Lấy thông tin vé của children
  ///
  Future<List<SaleOrderLine>> getTicketOfListChildren() async {
    Parent parent = Parent();
    List<SaleOrderLine> listResult = new List();
    await this.authorization();
    body = new Map();
    if (parent.listChildren.length == 0) return listResult;
    var domain = List<dynamic>();
    if (parent.listChildren.length > 1) {
      for (var i = 0; i < parent.listChildren.length - 1; i++) {
        domain.add("|");
      }
    }
    parent.listChildren.forEach((item) {
      domain.add(["order_partner_id", "=", item.id]);
    });
    body["domain"] = domain;
    var params = convertSerialize(body);
    return http
        .get('${this.api}/search_read/sale.order.line?$params',
            headers: this.headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0) {
          listResult =
              list.map((item) => SaleOrderLine.fromJson(item)).toList();
          listResult.forEach((item) {
            parent.listChildren.forEach((children) {
              if (item.orderPartnerId[0] == children.id)
                children.paidTicket = true;
            });
          });
          parent.saveLocal();
        }
      }
      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  ///Lấy session chuyến đi trong ngày của các children
  Future<List<ChildrenBusSession>> getListChildrenBusSession() async {
    await this.authorization();
    Parent parent = Parent();
    List<int> listChildrenId =
        parent.listChildren.map((item) => item.id).toList();
    var dateFrom = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var dateTo =
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1)));
    List<ChildrenBusSession> listResult = new List();
    body = new Map();
    body["domain"] = [
      ['saleorder_id.partner_id', 'in', listChildrenId],
      ['transport_date', '>=', dateFrom],
      ['transport_date', '<', dateTo],
    ];
    var params = convertSerialize(body);
    return http
        .get('${this.api}/search_read/picking.transport.info?$params',
            headers: this.headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0) {
          var listPickingTransportInfo =
              list.map((item) => PickingTransportInfo.fromJson(item)).toList();
          for (var pickingTransportInfo in listPickingTransportInfo) {
            var _saleOrder = await this
                .getSaleOrderById(pickingTransportInfo.saleorderId[0]);
            Children children;
            Driver driver;
            Parent parent = Parent();
            children = parent.listChildren.firstWhere((_child) {
              if (_saleOrder.partnerId is List)
                return _child.id == _saleOrder.partnerId[0];
              return false;
            });
            if (pickingTransportInfo.vehicleDriver is List) {
              var _driver = await this.getCustomerInfo(
                  pickingTransportInfo.vehicleDriver[0].toString());
              driver = Driver.fromResPartner(_driver);
            }

            listResult.add(ChildrenBusSession.fromPickingTransportInfo(
                pti: pickingTransportInfo,
                objChildren: children,
                objDriver: driver));
          }
        }
      }
      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  //Lấy thông tin sale order by id
  Future<SaleOrder> getSaleOrderById(int id) async {
    await this.authorization();
    body = new Map();
    body["domain"] = [
      ['id', '=', id],
    ];
    var params = convertSerialize(body);
    List<SaleOrder> listResult = new List();
    return http
        .get('${this.api}/search_read/sale.order?$params',
            headers: this.headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0)
          listResult = list.map((item) => SaleOrder.fromJson(item)).toList();
      }
      return listResult[0];
    }).catchError((error) {
      return null;
    });
  }

  // ///Lấy lịch trình driver
  // Future<List<DriverBusSession>> getListDriverBusSession(
  //     {int vehicleId, int driverId, String date}) async {
  //   var client = await this.authorizationOdoo();
  //   if (date == null) date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //   List<DriverBusSession> listResult = new List();
  //   body = new Map();
  //   body["vehicle_id"] = vehicleId;
  //   body["driver_id"] = driverId;
  //   body["date"] = date;
  //   print(body);
  //   return client
  //       .callController("/handle_picking_info_request", body)
  //       .then((onValue) async {
  //     try {
  //       var result = onValue.getResult();
  //       if (result['code'] != null) return listResult;
  //       var data = result["data"];
  //       for (var i = 0; i < 2; i++) {
  //         List resultData = (i == 0) ? data["outgoing"] : data["incoming"];
  //         if (resultData.length > 0) {
  //           List<ChildDrenStatus> listChildDrenStatus = List();
  //           List<ChildDrenRoute> listChildDrenRoute = List();
  //           List<RouteBus> listRouteBus = List();
  //           List<Children> listChildren = List();
  //           for (var j = 0; j < resultData.length; j++) {
  //             var objPicking = resultData[j]["obj_picking"];
  //             var partnerIds = objPicking["partner_ids"];
  //             List<Children> listChildrenForRoute = List();
  //             for (var k = 0; k < partnerIds.length; k++) {
  //               var partnerId = partnerIds[k]["partner_id"];
  //               //Tạo list Children
  //               listChildren.add(Children.fromJsonController(partnerId));
  //               //Tạo list Chidren for Route
  //               listChildrenForRoute
  //                   .add(Children.fromJsonController(partnerId));
  //               //Tạo list Children Status
  //               ChildDrenStatus childrenStatus = ChildDrenStatus();
  //               var pickingTransportInfo =
  //                   partnerIds[k]["picking_transport_info"];
  //               childrenStatus.id =
  //                   int.parse(pickingTransportInfo["id"].toString());
  //               childrenStatus.childrenID =
  //                   int.parse(partnerId["id"].toString());
  //               childrenStatus.routeBusID =
  //                   int.parse(objPicking["id"].toString());
  //               childrenStatus.typePickDrop =
  //                   partnerIds[k]["type"] == "pick" ? 0 : 1;
  //               childrenStatus.note = pickingTransportInfo["note"] is bool
  //                   ? ""
  //                   : pickingTransportInfo["note"];
  //               childrenStatus.pickingRoute = PickingRoute.fromJsonController(
  //                   pickingTransportInfo["picking_route"]);
  //               PickingTransportInfo_State.values.forEach((value) {
  //                 if (Common.getValueEnum(value) ==
  //                     pickingTransportInfo["state"])
  //                   switch (value) {
  //                     case PickingTransportInfo_State.draft:
  //                       childrenStatus.statusID = 0;
  //                       break;
  //                     case PickingTransportInfo_State.halt:
  //                       childrenStatus.statusID = 1;

  //                       break;
  //                     case PickingTransportInfo_State.done:
  //                       if (i == 0)
  //                         childrenStatus.statusID = 2;
  //                       else
  //                         childrenStatus.statusID = 4;
  //                       break;
  //                     case PickingTransportInfo_State.cancel:
  //                       childrenStatus.statusID = 3;
  //                       break;
  //                     default:
  //                   }
  //               });
  //               listChildDrenStatus.add(childrenStatus);
  //             }
  //             //Tạo list RouteBus
  //             RouteBus routeBus = RouteBus();
  //             routeBus.id = objPicking["id"];
  //             routeBus.routeName = objPicking["name"];
  //             routeBus.date = date;
  //             routeBus.time = objPicking["time"];
  //             routeBus.lat = double.parse(objPicking["lat"].toString());
  //             routeBus.lng = double.parse(objPicking["lng"].toString());
  //             routeBus.isSchool = objPicking["is_school"] is bool
  //                 ? objPicking["is_school"]
  //                 : false;
  //             routeBus.type = i == 0 ? 0 : 1;
  //             routeBus.status = false;
  //             listRouteBus.add(routeBus);

  //             //Tạo list Children Route
  //             ChildDrenRoute childrenRoute = ChildDrenRoute();
  //             childrenRoute.id = j + 1;
  //             childrenRoute.routeBusID = int.parse(objPicking["id"].toString());
  //             childrenRoute.listChildrenID =
  //                 listChildrenForRoute.map((item) => item.id).toList();
  //             listChildDrenRoute.add(childrenRoute);
  //           }
  //           //Xóa children đã tồn tại trong list children
  //           listChildren = Common.distinceArray<Children>(listChildren, "id");

  //           Driver driver = Driver();
  //           listResult.add(DriverBusSession.fromJsonController(
  //               busID: driver.vehicleName,
  //               date: date,
  //               type: i == 0 ? 0 : 1,
  //               listChildren: listChildren,
  //               listRouteBus: listRouteBus,
  //               childDrenRoute: listChildDrenRoute,
  //               childDrenStatus: listChildDrenStatus));
  //         }
  //       }
  //       if (listResult.length > 0) {
  //         Driver driver = Driver();
  //         for (var item in listResult) {
  //           item.status = await checkBusSessionFinished(
  //               vehicleId: driver.vehicleId, date: date, type: item.type);
  //         }
  //       }
  //       return listResult;
  //     } catch (ex) {
  //       return [];
  //     }
  //   });
  // }

  //Lấy lịch trình driver
  Future<List<DriverBusSession>> getListDriverBusSession(
      {int vehicleId, int driverId, String date}) async {
    var client = await this.authorizationOdoo();
    if (date == null) date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    List<DriverBusSession> listResult = new List();
    body = new Map();
    body["vehicle_id"] = vehicleId;
    body["driver_id"] = driverId;
    body["date"] = date;
    // body["vehicle_id"] = 116;
    // body["driver_id"] = 4609;
    // body["date"] = "2020-06-01";
    print(body);
    try {
      return client
          .callController("/handle_picking_info_request_v2", body)
          .then((onValue) async {
        try {
          var result = onValue.getResult();
          if (result['code'] != null) return listResult;
          var data = result["data"];
          if (data is List) if (data.length > 0)
            for (var i = 0; i < data.length; i++) {
              List resultData = data[i]["session"];
              int _pickDrop = (data[i]["type"] == "pick") ? 0 : 1;
              if (resultData.length > 0) {
                List<ChildDrenStatus> listChildDrenStatus = List();
                List<ChildDrenRoute> listChildDrenRoute = List();
                List<RouteBus> listRouteBus = List();
                List<Children> listChildren = List();
                for (var j = 0; j < resultData.length; j++) {
                  var objPicking = resultData[j]["obj_picking"];
                  var partnerIds = objPicking["partner_ids"];
                  List<Children> listChildrenForRoute = List();
                  for (var k = 0; k < partnerIds.length; k++) {
                    var partnerId = partnerIds[k]["partner_id"];
                    //Tạo list Children
                    listChildren.add(Children.fromJsonController(partnerId));
                    //Tạo list Chidren for Route
                    listChildrenForRoute
                        .add(Children.fromJsonController(partnerId));
                    //Tạo list Children Status
                    ChildDrenStatus childrenStatus = ChildDrenStatus();
                    var pickingTransportInfo =
                        partnerIds[k]["picking_transport_info"];
                    childrenStatus.id =
                        int.parse(pickingTransportInfo["id"].toString());
                    childrenStatus.childrenID = (partnerId["id"] is bool)
                        ? 0
                        : int.parse(partnerId["id"].toString());
                    childrenStatus.routeBusID =
                        int.parse(objPicking["id"].toString());
                    childrenStatus.typePickDrop =
                        partnerIds[k]["type"] == "pick" ? 0 : 1;
                    childrenStatus.note = pickingTransportInfo["note"] is bool
                        ? ""
                        : pickingTransportInfo["note"];
                    childrenStatus.pickingRoute =
                        PickingRoute.fromJsonController(
                            pickingTransportInfo["picking_route"]);
                    PickingTransportInfo_State.values.forEach((value) {
                      if (Common.getValueEnum(value) ==
                          pickingTransportInfo["state"])
                        switch (value) {
                          case PickingTransportInfo_State.draft:
                            childrenStatus.statusID = 0;
                            break;
                          case PickingTransportInfo_State.halt:
                            childrenStatus.statusID = 1;

                            break;
                          case PickingTransportInfo_State.done:
                            if (_pickDrop == 0)
                              childrenStatus.statusID = 2;
                            else
                              childrenStatus.statusID = 4;
                            break;
                          case PickingTransportInfo_State.cancel:
                            childrenStatus.statusID = 3;
                            break;
                          default:
                        }
                    });
                    listChildDrenStatus.add(childrenStatus);
                  }
                  //Tạo list RouteBus
                  RouteBus routeBus = RouteBus();
                  routeBus.id = objPicking["id"];
                  routeBus.routeName = objPicking["name"];
                  routeBus.date = date;
                  routeBus.time = objPicking["time"];
                  routeBus.lat = double.parse(objPicking["lat"].toString());
                  routeBus.lng = double.parse(objPicking["lng"].toString());
                  routeBus.isSchool = objPicking["is_school"] is bool
                      ? objPicking["is_school"]
                      : false;
                  routeBus.type = _pickDrop == 0 ? 0 : 1;
                  routeBus.status = false;
                  listRouteBus.add(routeBus);

                  //Tạo list Children Route
                  ChildDrenRoute childrenRoute = ChildDrenRoute();
                  childrenRoute.id = j + 1;
                  childrenRoute.routeBusID =
                      int.parse(objPicking["id"].toString());
                  childrenRoute.listChildrenID =
                      listChildrenForRoute.map((item) => item.id).toList();
                  listChildDrenRoute.add(childrenRoute);
                }
                //Xóa children đã tồn tại trong list children
                listChildren =
                    Common.distinceArray<Children>(listChildren, "id");

                Driver driver = Driver();
                listResult.add(DriverBusSession.fromJsonController(
                    busID: driver.vehicleName,
                    date: date,
                    type: _pickDrop == 0 ? 0 : 1,
                    listChildren: listChildren,
                    listRouteBus: listRouteBus,
                    childDrenRoute: listChildDrenRoute,
                    childDrenStatus: listChildDrenStatus));
              }
            }
          if (listResult.length > 0) {
            Driver driver = Driver();
            for (var item in listResult) {
              item.status = await checkBusSessionFinished(
                  vehicleId: driver.vehicleId, date: date, type: item.type);
            }
          }
          return listResult;
        } catch (ex) {
          return [];
        }
      });
    } catch (ex) {
      return [];
    }
  }

  // ///Lấy lịch sử chuyến đi của driver
  // Future<List<HistoryDriver>> getHistoryDriver({int take, int skip}) async {
  //   var client = await this.authorizationOdoo();
  //   Driver driver = Driver();
  //   var _driverId = driver.isDriver == true ? driver.id : driver.driverId;
  //   List<HistoryDriver> listResult = new List();
  //   body = new Map();
  //   body["driver_id"] = _driverId;
  //   body["vehicle_id"] = driver.vehicleId;
  //   body["take"] = take;
  //   body["skip"] = skip;
  //   try {
  //     return client
  //         .callController("/handle_picking_info_request_history", body)
  //         .then((onValue) async {
  //       var result = onValue.getResult();
  //       if (!(result is List)) return listResult;
  //       for (var h = 0; h < result.length; h++) {
  //         var data = result[h];
  //         HistoryDriver historyDriver = HistoryDriver();
  //         var date = data["transport_date"];
  //         historyDriver.transportDate = date;
  //         historyDriver.listHistory = [];
  //         historyDriver.listUrlHistoryPositions = [];
  //         for (var i = 0; i < 2; i++) {
  //           List resultData = (i == 0) ? data["outgoing"] : data["incoming"];
  //           if (resultData.length > 0) {
  //             List<ChildDrenStatus> listChildDrenStatus = List();
  //             List<ChildDrenRoute> listChildDrenRoute = List();
  //             List<RouteBus> listRouteBus = List();
  //             List<Children> listChildren = List();
  //             for (var j = 0; j < resultData.length; j++) {
  //               var objPicking = resultData[j]["obj_picking"];
  //               var partnerIds = objPicking["partner_ids"];
  //               List<Children> listChildrenForRoute = List();
  //               for (var k = 0; k < partnerIds.length; k++) {
  //                 var partnerId = partnerIds[k]["partner_id"];
  //                 //Tạo list Children
  //                 listChildren.add(Children.fromJsonController(partnerId));
  //                 //Tạo list Chidren for Route
  //                 listChildrenForRoute
  //                     .add(Children.fromJsonController(partnerId));
  //                 //Tạo list Children Status
  //                 ChildDrenStatus childrenStatus = ChildDrenStatus();
  //                 var pickingTransportInfo =
  //                     partnerIds[k]["picking_transport_info"];
  //                 childrenStatus.id =
  //                     int.parse(pickingTransportInfo["id"].toString());
  //                 childrenStatus.childrenID = (partnerId["id"] is bool)
  //                     ? 0
  //                     : int.parse(partnerId["id"].toString());
  //                 childrenStatus.routeBusID =
  //                     int.parse(objPicking["id"].toString());
  //                 childrenStatus.typePickDrop =
  //                     partnerIds[k]["type"] == "pick" ? 0 : 1;
  //                 childrenStatus.note = pickingTransportInfo["note"] is bool
  //                     ? ""
  //                     : pickingTransportInfo["note"];
  //                 childrenStatus.pickingRoute = PickingRoute.fromJsonController(
  //                     pickingTransportInfo["picking_route"]);
  //                 PickingTransportInfo_State.values.forEach((value) {
  //                   if (Common.getValueEnum(value) ==
  //                       pickingTransportInfo["state"])
  //                     switch (value) {
  //                       case PickingTransportInfo_State.draft:
  //                         childrenStatus.statusID = 0;
  //                         break;
  //                       case PickingTransportInfo_State.halt:
  //                         childrenStatus.statusID = 1;

  //                         break;
  //                       case PickingTransportInfo_State.done:
  //                         if (i == 0)
  //                           childrenStatus.statusID = 2;
  //                         else
  //                           childrenStatus.statusID = 4;
  //                         break;
  //                       case PickingTransportInfo_State.cancel:
  //                         childrenStatus.statusID = 3;
  //                         break;
  //                       default:
  //                     }
  //                 });
  //                 listChildDrenStatus.add(childrenStatus);
  //               }
  //               //Tạo list RouteBus
  //               RouteBus routeBus = RouteBus();
  //               routeBus.id = objPicking["id"];
  //               routeBus.routeName = objPicking["name"];
  //               routeBus.date = date;
  //               routeBus.time = objPicking["time"];
  //               routeBus.lat = double.parse(objPicking["lat"].toString());
  //               routeBus.lng = double.parse(objPicking["lng"].toString());
  //               routeBus.isSchool = false;
  //               routeBus.type = i == 0 ? 0 : 1;
  //               routeBus.status = false;
  //               listRouteBus.add(routeBus);

  //               //Tạo list Children Route
  //               ChildDrenRoute childrenRoute = ChildDrenRoute();
  //               childrenRoute.id = j + 1;
  //               childrenRoute.routeBusID =
  //                   int.parse(objPicking["id"].toString());
  //               childrenRoute.listChildrenID =
  //                   listChildrenForRoute.map((item) => item.id).toList();
  //               listChildDrenRoute.add(childrenRoute);
  //             }
  //             //Xóa children đã tồn tại trong list children
  //             listChildren = Common.distinceArray<Children>(listChildren, "id");

  //             Driver driver = Driver();
  //             historyDriver.listHistory.add(DriverBusSession.fromJsonController(
  //                 busID: driver.vehicleName,
  //                 date: date,
  //                 type: i == 0 ? 0 : 1,
  //                 listChildren: listChildren,
  //                 listRouteBus: listRouteBus,
  //                 childDrenRoute: listChildDrenRoute,
  //                 childDrenStatus: listChildDrenStatus,
  //                 status: true));
  //           }
  //           historyDriver.listHistory.forEach((driverBusSession) {
  //             historyDriver.listUrlHistoryPositions.add("");
  //           });
  //         }
  //         listResult.add(historyDriver);
  //       }
  //       return listResult;
  //     });
  //   } catch (ex) {
  //     return [];
  //   }
  // }

  ///Lấy lịch sử chuyến đi của driver
  Future<List<HistoryDriver>> getHistoryDriver({int take, int skip}) async {
    var client = await this.authorizationOdoo();
    Driver driver = Driver();
    var _driverId = driver.isDriver == true ? driver.id : driver.driverId;
    List<HistoryDriver> listResult = new List();
    body = new Map();
    body["driver_id"] = _driverId;
    body["vehicle_id"] = driver.vehicleId;
    body["take"] = take;
    body["skip"] = skip;
    try {
      return client
          .callController("/handle_picking_info_request_history_v2", body)
          .then((onValue) async {
        var result = onValue.getResult();
        if (!(result is List)) return listResult;
        for (var h = 0; h < result.length; h++) {
          var data = result[h];
          HistoryDriver historyDriver = HistoryDriver();
          var date = data["transport_date"];
          List childData = data["data"];
          historyDriver.transportDate = date;
          historyDriver.listHistory = [];
          historyDriver.listUrlHistoryPositions = [];
          for (var i = 0; i < childData.length; i++) {
            List resultData = childData[i]["session"];
            if (resultData.length > 0) {
              List<ChildDrenStatus> listChildDrenStatus = List();
              List<ChildDrenRoute> listChildDrenRoute = List();
              List<RouteBus> listRouteBus = List();
              List<Children> listChildren = List();
              for (var j = 0; j < resultData.length; j++) {
                var objPicking = resultData[j]["obj_picking"];
                var partnerIds = objPicking["partner_ids"];
                List<Children> listChildrenForRoute = List();
                for (var k = 0; k < partnerIds.length; k++) {
                  var partnerId = partnerIds[k]["partner_id"];
                  //Tạo list Children
                  listChildren.add(Children.fromJsonController(partnerId));
                  //Tạo list Chidren for Route
                  listChildrenForRoute
                      .add(Children.fromJsonController(partnerId));
                  //Tạo list Children Status
                  ChildDrenStatus childrenStatus = ChildDrenStatus();
                  var pickingTransportInfo =
                      partnerIds[k]["picking_transport_info"];
                  childrenStatus.id =
                      int.parse(pickingTransportInfo["id"].toString());
                  childrenStatus.childrenID = (partnerId["id"] is bool)
                      ? 0
                      : int.parse(partnerId["id"].toString());
                  childrenStatus.routeBusID =
                      int.parse(objPicking["id"].toString());
                  childrenStatus.typePickDrop =
                      partnerIds[k]["type"] == "pick" ? 0 : 1;
                  childrenStatus.note = pickingTransportInfo["note"] is bool
                      ? ""
                      : pickingTransportInfo["note"];
                  childrenStatus.pickingRoute = PickingRoute.fromJsonController(
                      pickingTransportInfo["picking_route"]);
                  PickingTransportInfo_State.values.forEach((value) {
                    if (Common.getValueEnum(value) ==
                        pickingTransportInfo["state"])
                      switch (value) {
                        case PickingTransportInfo_State.draft:
                          childrenStatus.statusID = 0;
                          break;
                        case PickingTransportInfo_State.halt:
                          childrenStatus.statusID = 1;

                          break;
                        case PickingTransportInfo_State.done:
                          if (i == 0)
                            childrenStatus.statusID = 2;
                          else
                            childrenStatus.statusID = 4;
                          break;
                        case PickingTransportInfo_State.cancel:
                          childrenStatus.statusID = 3;
                          break;
                        default:
                      }
                  });
                  listChildDrenStatus.add(childrenStatus);
                }
                //Tạo list RouteBus
                RouteBus routeBus = RouteBus();
                routeBus.id = objPicking["id"];
                routeBus.routeName = objPicking["name"];
                routeBus.date = date;
                routeBus.time = objPicking["time"];
                routeBus.lat = double.parse(objPicking["lat"].toString());
                routeBus.lng = double.parse(objPicking["lng"].toString());
                routeBus.isSchool = false;
                routeBus.type = i == 0 ? 0 : 1;
                routeBus.status = false;
                listRouteBus.add(routeBus);

                //Tạo list Children Route
                ChildDrenRoute childrenRoute = ChildDrenRoute();
                childrenRoute.id = j + 1;
                childrenRoute.routeBusID =
                    int.parse(objPicking["id"].toString());
                childrenRoute.listChildrenID =
                    listChildrenForRoute.map((item) => item.id).toList();
                listChildDrenRoute.add(childrenRoute);
              }
              //Group lại listChildrenRoute cho trường hợp 1 địa điểm chia làm nhiều dòng.
              listChildDrenRoute =
                  ChildDrenRoute.groupByRouteId(listChildDrenRoute);
              //Xóa children đã tồn tại trong list children
              listChildren = Common.distinceArray<Children>(listChildren, "id");

              Driver driver = Driver();
              historyDriver.listHistory.add(DriverBusSession.fromJsonController(
                  busID: driver.vehicleName,
                  date: date,
                  type: i == 0 ? 0 : 1,
                  listChildren: listChildren,
                  listRouteBus: listRouteBus,
                  childDrenRoute: listChildDrenRoute,
                  childDrenStatus: listChildDrenStatus,
                  status: true));
            }
            historyDriver.listHistory.forEach((driverBusSession) {
              historyDriver.listUrlHistoryPositions.add("");
            });
          }

          listResult.add(historyDriver);
        }
        return listResult;
      });
    } catch (ex) {
      return [];
    }
  }

  ///Kiểm tra chuyến đi đã hoàn thành
  Future<bool> checkBusSessionFinished(
      {int vehicleId, int type, String date}) async {
    var client = await this.authorizationOdoo();
    body = new Map();
    body["vehicle_id"] = vehicleId;
    body["type"] = type == 0 ? "pick" : "drop";
    body["date"] = date;
    bool check = false;
    return client
        .callController("/check_driver_picking_info", body)
        .then((onValue) {
      var result = onValue.getResult();
      check = result;
      return check;
    });
  }

  ///Update thông tin khách hàng
  ///
  ///Success - Trả về true
  ///
  ///Fail - Trả về false
  Future<bool> updateCustomer(ResPartner partner) async {
    await this.authorization();
    body = new Map();
    body["model"] = "res.partner";
    body["ids"] = json.encode([partner.id]);
    body["values"] = json.encode(partner.toJson());
    return http
        .put('${this.api}/write', headers: this.headers, body: body)
        .then((http.Response response) {
      var result = false;
      if (response.statusCode == 200) {
        print(response.body);
        result = true;
        //print(list);
      } else {
        result = false;
      }
      return result;
    });
  }

  ///Update thông tin chuyến xe
  ///
  ///Success - Trả về true
  ///
  ///Fail - Trả về false
  Future<bool> updatePickingTransportInfo(PickingTransportInfo picking) async {
    await this.authorization();
    body = new Map();
    body["model"] = "picking.transport.info";
    body["ids"] = json.encode([int.parse(picking.id.toString())]);
    body["values"] = json.encode(picking.toJson());
    return http
        .put('${this.api}/write', headers: this.headers, body: body)
        .then((http.Response response) {
      var result = false;
      if (response.statusCode == 200) {
        print(response.body);
        result = true;
        //print(list);
      } else {
        result = false;
      }
      return result;
    });
  }

  ///Update trang thai nghỉ theo id picking
  ///listIdPicking
  Future<bool> updateLeaveByIdPicking(List<int> listIdPicking) async {
    await this.authorization();
    var client = await this.authorizationOdoo();
    return client.callKW("picking.transport.info", "picking_cancel",
        [listIdPicking]).then((onValue) {
      var error = onValue.getError();
      if (error == null) return true;
      return false;
    });
  }

  ///Update trạng thái đón theo id picking
  ///listIdPicking
  Future<bool> updateStatusPickByIdPicking(List<int> listIdPicking) async {
    await this.authorization();
    var client = await this.authorizationOdoo();
    return client
        .callKW("picking.transport.info", "picking_hold", [listIdPicking]).then(
            (onValue) {
      var error = onValue.getError();
      if (error == null) return true;
      return false;
    });
  }

  ///Update tọa độ vehicle
  ///
  ///Success - Trả về true
  ///
  ///Fail - Trả về false
  Future<bool> updateCoordinateVehicle(int vehicleId, Position location) async {
    await this.authorization();
    FleetVehicle fleetVehicle = FleetVehicle.fromPositionData(location);
    fleetVehicle.id = vehicleId;
    body = new Map();
    body["model"] = "fleet.vehicle";
    body["ids"] = json.encode(vehicleId);
    body["values"] = json.encode(fleetVehicle.toJson());
    return http
        .put('${this.api}/write', headers: this.headers, body: body)
        .then((http.Response response) {
      var result = false;
      if (response.statusCode == 200) {
        print(response.body);
        result = true;
        //print(list);
      } else {
        result = false;
      }
      return result;
    });
  }

  ///Update trạng thái trả theo id picking
  ///listIdPicking
  Future<bool> updateStatusDropByIdChildren(List<int> listIdPicking) async {
    await this.authorization();
    var client = await this.authorizationOdoo();
    return client
        .callKW("picking.transport.info", "picking_done", [listIdPicking]).then(
            (onValue) {
      var error = onValue.getError();
      if (error == null) return true;
      return false;
    });
  }

  ///Update tọa độ và thời điểm xe đến trạm
  Future<bool> updatePickingRouteByDriver(
      PickingRoute pickingRoute, int typePickDrop) async {
    //Location location = Location();
    //var myLoc = await location.getLocation();
    PickingRoute _pickingRoute = PickingRoute();
    _pickingRoute.id = pickingRoute.id;
    var date = DateTime.now();
    var strDateTime = DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(date.add(Duration(hours: -date.timeZoneOffset.inHours)))
        .toString();
    if (typePickDrop == 0) {
      //pickingRoute.gpsTracking = "${myLoc.latitude},${myLoc.longitude}";
      _pickingRoute.xRealStartTime = strDateTime;
      _pickingRoute.status = "halt";
    } else {
      // pickingRoute.xGpsTrackingDes = "${myLoc.latitude},${myLoc.longitude}";
      _pickingRoute.xRealEndTime = strDateTime;
      _pickingRoute.status = "reach";
    }
    await this.authorization();
    body = new Map();
    body["model"] = "picking.route";
    body["ids"] = json.encode([int.parse(_pickingRoute.id.toString())]);
    body["values"] = json.encode(_pickingRoute.toJsonUpdate(typePickDrop));
    return http
        .put('${this.api}/write', headers: this.headers, body: body)
        .then((http.Response response) {
      this.updateCroodPickingRouteByDriver(pickingRoute, typePickDrop);
      var result = false;
      if (response.statusCode == 200) {
        print(response.body);
        result = true;
        //print(list);
      } else {
        result = false;
      }
      return result;
    });
  }

  ///Update tọa độ và thời điểm xe đến trạm
  Future<bool> updateCroodPickingRouteByDriver(
      PickingRoute pickingRoute, int typePickDrop) async {
    PickingRoute _pickingRoute = PickingRoute();
    _pickingRoute.id = pickingRoute.id;
    Location location = Location();
    var myLoc = await location.getLocation();
    if (typePickDrop == 0) {
      _pickingRoute.gpsTracking = "${myLoc.latitude},${myLoc.longitude}";
      _pickingRoute.status = "halt";
    } else {
      _pickingRoute.xGpsTrackingDes = "${myLoc.latitude},${myLoc.longitude}";
      _pickingRoute.status = "reach";
    }
    await this.authorization();
    body = new Map();
    body["model"] = "picking.route";
    body["ids"] = json.encode([int.parse(_pickingRoute.id.toString())]);
    body["values"] = json.encode(_pickingRoute.toJsonUpdate(typePickDrop));
    return http
        .put('${this.api}/write', headers: this.headers, body: body)
        .then((http.Response response) {
      var result = false;
      if (response.statusCode == 200) {
        print(response.body);
        result = true;
        //print(list);
      } else {
        result = false;
      }
      return result;
    });
  }

  ///Update field user_check_done để xác định driver hoặc attendant kết thúc chuyến
  ///@params
  ///
  ///listIdPicking
  ///
  ///role
  ///(0 : driver ; 1: manager)
  Future<bool> updateUserRoleFinishedBusSession(
      List<int> listIdPicking, int role) async {
    var client = await this.authorizationOdoo();
    body = new Map();
    body["list_picking_id"] = listIdPicking;
    body["role"] = role == 0 ? "driver" : "manager";
    bool check = false;
    return client
        .callController("/update_user_check_done", body)
        .then((onValue) {
      var result = onValue.getResult();
      check = result;
      return check;
    });
  }

  ///Kiểm tra field user_check_done để xác định chuyến đã kết thúc
  ///@params
  ///listIdPicking
  Future<bool> checkUserRoleFinishedBusSession(List<int> listIdPicking) async {
    var client = await this.authorizationOdoo();
    body = new Map();
    body["list_picking_id"] = listIdPicking;
    bool check = false;
    return client
        .callController("/check_type_user_check_done", body)
        .then((onValue) {
      var result = onValue.getResult();
      check = result["check"];
      return check;
    });
  }

  ///Insert thông tin khách hàng
  ///
  ///Success - Trả về new id
  ///
  ///Fail - Trả về null
  Future<dynamic> insertCustomer(ResPartner partner) async {
    await this.authorization();
    body = new Map();
    body["model"] = "res.partner";
    body["values"] = json.encode(partner.toJson());
    return http
        .post('${this.api}/create', headers: this.headers, body: body)
        .then((http.Response response) {
      var result;
      if (response.statusCode == 200) {
        var list = json.decode(response.body);
        if (list is List) result = list[0];
        //print(list);
      } else {
        result = null;
      }
      return result;
    });
  }

  ///Update lich trinh driver
  ///@params String listIdRouteBus
  ////@params int vehicleId
  /// @params int driverId
  /// @param int type : 0 là chuyến đi, 1 là chuyến về
  Future<bool> updateListRouteBus(
      {List<int> listIdRouteBus,
      int vehicleId,
      int driverId,
      int type = 0}) async {
    var client = await this.authorizationOdoo();
    body = new Map();
    var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    body["list_route_location"] = listIdRouteBus;
    body["vehicle_id"] = vehicleId;
    body["driver_id"] = driverId;
    body["date"] = date;
    body["type"] = type == 0 ? "pick" : "drop";
    print(body);
    bool check = false;
    return client
        .callController("/update_saleorder_sequence", body)
        .then((onValue) {
      var result = onValue.getResult();
      if (result['status'] != null) check = result['status'];
      return check;
    });
  }

  ///Update tọa độ cho routeBus
  ///
  ///Success - Trả về true
  ///
  ///Fail - Trả về false
  Future<bool> updateCoordRouteBus(RouteBus routeBus) async {
    await this.authorization();
    RouteLocation routeLocation = RouteLocation.fromRouteBus(routeBus);
    body = new Map();
    body["model"] = "route.location";
    body["ids"] = json.encode(routeBus.id);
    body["values"] = json.encode(routeLocation.toJsonUpdateCoord());
    return http
        .put('${this.api}/write', headers: this.headers, body: body)
        .then((http.Response response) {
      var result = false;
      if (response.statusCode == 200) {
        print(response.body);
        result = true;
        //print(list);
      } else {
        result = false;
      }
      return result;
    });
  }

  ///Kiểm tra quyền pick drop của user
  Future<bool> checkPermissionPickDropByEmail() async {
    var client = await this.authorizationOdoo();
    Driver driver = Driver();
    body = new Map();
    body["email"] = driver.email;
    bool check = false;
    try {
      return client
          .callController("/check_user_right_picking_route", body)
          .then((onValue) {
        var result = onValue.getResult();
        check = result["result"];
        return check;
      });
    } catch (ex) {
      return check;
    }
  }

  /*---------------OneSignal----------------- */
  Future<dynamic> postNotificationChangeStatus(
      Children children, ChildDrenStatus childDrenStatus) async {
    //   StatusBus(0, "Đang chờ", 0xFFFFD752),
    //   StatusBus(1, "Đang trong chuyến", 0xFF8FD838),
    //   StatusBus(2, "Đã tới trường", 0xFF3DABEC),
    //   StatusBus(3, "Nghỉ học", 0xFFE80F0F),
    //   StatusBus(4, "Đã về nhà", 0xFF6F32A0),
    // }
    String notificationVI = "${children.name} ";
    Driver driver = Driver();
    switch (childDrenStatus.statusID) {
      case 1:
        notificationVI += StatusBus.list[1].statusName.toLowerCase();
        break;
      case 2:
        notificationVI += StatusBus.list[2].statusName.toLowerCase();
        break;
      case 3:
        notificationVI +=
            "được xác nhận ${StatusBus.list[3].statusName.toLowerCase()} từ ${driver.name}";
        break;
      case 4:
        notificationVI += StatusBus.list[4].statusName.toLowerCase();
        break;
      default:
    }
    notificationVI += ".";
    String notificationEN = "${children.name} ";
    switch (childDrenStatus.statusID) {
      case 1:
        notificationEN += StatusBus.list[1].statusName.toLowerCase();
        break;
      case 2:
        notificationEN += StatusBus.list[2].statusName.toLowerCase();
        break;
      case 3:
        notificationEN +=
            "Confirmed ${StatusBus.list[3].statusName.toLowerCase()} from ${driver.name}";
        break;
      case 4:
        notificationEN += StatusBus.list[4].statusName.toLowerCase();
        break;
      default:
    }
    notificationEN += ".";
    for (var i = 0; i < 2; i++) {
      BodyNotification body = BodyNotification();
      String language;
      switch (i) {
        case 0:
          language = "vi";
          body.headings = {
            "en": "Thông báo từ Bus2School",
          };

          body.contents = {"en": notificationVI};
          break;
        case 1:
          language = "en";
          body.headings = {"en": "Notify from Bus2School"};
          body.contents = {"en": notificationEN};
          break;
        default:
      }
      body.filters = [
        {
          "field": "tag",
          "key": "id",
          "relation": "=",
          "value": children.parent.id
        },
        {"field": "tag", "key": "language", "relation": "=", "value": language}
      ];
      OneSignalService.postNotification(body);
    }
  }

  Future<dynamic> postNotificationBusIsComing(
      List<Children> listChildren, String time,
      {bool isCome = false}) async {
    for (var i = 0; i < listChildren.length; i++) {
      var children = listChildren[i];

      String notificationVI = isCome == false
          ? "Xe sắp đến trong vòng $time phút, mời em ${children.name} chuẩn bị ra xe."
          : "Xe đã đến, mời em ${children.name} nhanh chóng ra xe.";
      String notificationEN = isCome == false
          ? "The bus is comming for $time minute, ${children.name} let's ready."
          : "The bus has arrived, ${children.name} get in the bus.";
      for (var i = 0; i < 2; i++) {
        BodyNotification body = BodyNotification();
        String language;
        switch (i) {
          case 0:
            language = "vi";
            body.headings = {
              "en": "Thông báo từ Bus2School",
            };

            body.contents = {"en": notificationVI};
            break;
          case 1:
            language = "en";
            body.headings = {"en": "Notify from Bus2School"};
            body.contents = {"en": notificationEN};
            break;
          default:
        }
        body.filters = [
          {
            "field": "tag",
            "key": "id",
            "relation": "=",
            "value": children.parent.id
          },
          {
            "field": "tag",
            "key": "language",
            "relation": "=",
            "value": language
          }
        ];
        OneSignalService.postNotification(body);
      }
    }
  }

  ///Gửi thông báo các sự cố
  ///@params.
  ///listChildren
  ///type
  ///- 0: kẹt xe nghiêm trọng
  //- 1: tai nạn giao thông
  // - 2: học sinh cấp cứu
  // - 3: sự cố khác
  Future<dynamic> postNotificationProblem(List<Children> listChildren, int type,
      {String content}) async {
    var myLoc = await Location().getLocation();
    var placeMark = await Geolocator()
        .placemarkFromCoordinates(myLoc.latitude, myLoc.longitude);
    var addressLocation = placeMark[0].name +
        placeMark[0].thoroughfare +
        placeMark[0].subAdministrativeArea;
    for (var i = 0; i < listChildren.length; i++) {
      var children = listChildren[i];
      String notificationVI = "";
      String notificationEN = '';
      Driver driver = Driver();
      switch (type) {
        case 0:
          notificationVI =
              """${driver.vehicleName} đang bị kẹt xe nghiêm trọng tại $addressLocation.
          Vui lòng truy cập ứng dụng đê cập nhật vị trí xe.
          """;
          notificationEN =
              """${driver.vehicleName} is stuck at $addressLocation very serious.
          Please open the application and check the location details.
          """;
          break;
        case 1:
          notificationVI =
              """${driver.vehicleName} đang bị tai nạn giao thông tại $addressLocation.
          Vui lòng truy cập ứng dụng đê cập nhật vị trí xe.
          """;
          notificationEN =
              """${driver.vehicleName} being traffic accidents at $addressLocation.
          Please open the application and check the location details.
          """;
          break;
        case 2:
          notificationVI =
              """Em ${children.name} đang gặp tai nạn tại $addressLocation.
          Vui lòng truy cập ứng dụng đê cập nhật vị trí xe.
          """;
          notificationEN =
              """${children.name} being traffic accidents at $addressLocation.
          Please open the application and check the location details.
          """;
          break;
        case 3:
          notificationVI = content;
          notificationEN = content;
          break;
        default:
      }
      for (var i = 0; i < 2; i++) {
        BodyNotification body = BodyNotification();
        String language;
        switch (i) {
          case 0:
            language = "vi";
            body.headings = {
              "en": "Thông báo từ Bus2School",
            };

            body.contents = {"en": notificationVI};
            break;
          case 1:
            language = "en";
            body.headings = {"en": "Notify from Bus2School"};
            body.contents = {"en": notificationEN};
            break;
          default:
        }
        body.filters = [
          {
            "field": "tag",
            "key": "id",
            "relation": "=",
            "value": children.parent.id
          },
          {
            "field": "tag",
            "key": "language",
            "relation": "=",
            "value": language
          }
        ];
        OneSignalService.postNotification(body);
      }
    }
  }

  ///Gửi thông báo chat
  ///@param object messages
  Future<dynamic> postNotificationSendMessage(Messages messages) async {
    String notification = messages.content;
    if (notification.length > 100)
      notification = notification.substring(0, 100) + "...";
    Driver driver = Driver();
    for (var i = 0; i < 2; i++) {
      BodyNotification body = BodyNotification();
      String language;
      switch (i) {
        case 0:
          language = "vi";
          body.headings = {"en": "Bạn có tin nhắn từ ${driver.name}"};
          break;
        case 1:
          language = "en";
          body.headings = {"en": "You have a message from ${driver.name}"};
          break;
        default:
      }
      body.contents = {"en": notification};
      body.data = messages.toJsonPushNotification();
      body.filters = [
        {
          "field": "tag",
          "key": "id",
          "relation": "=",
          "value": int.parse(messages.receiverId)
        },
        {"field": "tag", "key": "language", "relation": "=", "value": language}
      ];
      OneSignalService.postNotification(body);
      OneSignalService.postNotificationSameApplication(body);
    }
  }
}
