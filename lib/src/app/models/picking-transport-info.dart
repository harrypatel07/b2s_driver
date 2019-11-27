import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/service/common-service.dart';

enum PickingTransportInfo_State {
  draft,
  halt,
  done,
  cancel,
  res,
}

class PickingTransportInfo {
  dynamic sLastUpdate;
  dynamic accessToken;
  dynamic accessUrl;
  dynamic accessWarning;
  dynamic activityDateDeadline;
  List<dynamic> activityIds;
  dynamic activityState;
  dynamic activitySummary;
  dynamic activityTypeId;
  dynamic activityUserId;
  dynamic carrierId;
  dynamic carrierTrackingRef;
  List<dynamic> companyId;
  dynamic createDate;
  List<dynamic> createUid;
  dynamic customerId;
  List<dynamic> deliveryId;
  dynamic destinationId;
  dynamic displayName;
  dynamic id;
  dynamic lrNumber;
  dynamic messageAttachmentCount;
  List<dynamic> messageChannelIds;
  List<dynamic> messageFollowerIds;
  dynamic messageHasError;
  dynamic messageHasErrorCounter;
  List<dynamic> messageIds;
  dynamic messageIsFollower;
  dynamic messageMainAttachmentId;
  dynamic messageNeedaction;
  dynamic messageNeedactionCounter;
  List<dynamic> messagePartnerIds;
  dynamic messageUnread;
  dynamic messageUnreadCounter;
  dynamic name;
  dynamic noOfParcel;
  dynamic note;
  dynamic numberOfPackages;
  List<dynamic> pickingRouteIds;
  List<dynamic> saleorderId;
  dynamic shippingWeight;
  dynamic state;
  dynamic transportDate;
  List<dynamic> transporterId;
  List<dynamic> userId;
  List<dynamic> vehicleDriver;
  dynamic vehicleId;
  List<dynamic> websiteMessageIds;
  dynamic weight;
  dynamic weightUomId;
  dynamic writeDate;
  List<dynamic> writeUid;
  dynamic xTime;
  PickingTransportInfo(
      {this.sLastUpdate,
      this.accessToken,
      this.accessUrl,
      this.accessWarning,
      this.activityDateDeadline,
      this.activityIds,
      this.activityState,
      this.activitySummary,
      this.activityTypeId,
      this.activityUserId,
      this.carrierId,
      this.carrierTrackingRef,
      this.companyId,
      this.createDate,
      this.createUid,
      this.customerId,
      this.deliveryId,
      this.destinationId,
      this.displayName,
      this.id,
      this.lrNumber,
      this.messageAttachmentCount,
      this.messageChannelIds,
      this.messageFollowerIds,
      this.messageHasError,
      this.messageHasErrorCounter,
      this.messageIds,
      this.messageIsFollower,
      this.messageMainAttachmentId,
      this.messageNeedaction,
      this.messageNeedactionCounter,
      this.messagePartnerIds,
      this.messageUnread,
      this.messageUnreadCounter,
      this.name,
      this.noOfParcel,
      this.note,
      this.numberOfPackages,
      this.pickingRouteIds,
      this.saleorderId,
      this.shippingWeight,
      this.state,
      this.transportDate,
      this.transporterId,
      this.userId,
      this.vehicleDriver,
      this.vehicleId,
      this.websiteMessageIds,
      this.weight,
      this.weightUomId,
      this.writeDate,
      this.writeUid,
      this.xTime});

  PickingTransportInfo.fromChildrenStatus(ChildDrenStatus childrenStatus) {
    id = childrenStatus.id;
    Driver driver = Driver();
    note = childrenStatus.note = driver.isDriver == false ? "QLĐĐ" : "TX";
    switch (childrenStatus.statusID) {
      // StatusBus(0, "Đang chờ", 0xFFFFD752),
      // StatusBus(1, "Đang trong chuyến", 0xFF8FD838),
      // StatusBus(2, "Đã tới trường", 0xFF3DABEC),
      // StatusBus(3, "Nghỉ học", 0xFFE80F0F),
      // StatusBus(4, "Đã về nhà", 0xFF6F32A0),
      case 0:
        state = Common.getValueEnum(PickingTransportInfo_State.draft);
        break;
      case 1:
        state = Common.getValueEnum(PickingTransportInfo_State.halt);
        break;
      case 2:
        state = Common.getValueEnum(PickingTransportInfo_State.done);
        break;
      case 3:
        state = Common.getValueEnum(PickingTransportInfo_State.cancel);
        break;
      case 4:
        state = Common.getValueEnum(PickingTransportInfo_State.done);

        break;
      default:
    }
  }
  PickingTransportInfo.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    accessToken = json['access_token'];
    accessUrl = json['access_url'];
    accessWarning = json['access_warning'];
    activityDateDeadline = json['activity_date_deadline'];
    if (json["activity_ids"] != null) {
      activityIds = List<dynamic>.from(json["activity_ids"] != null &&
              (json["activity_ids"] is bool) == false
          ? json["activity_ids"]
          : []);
    }
    activityState = json['activity_state'];
    activitySummary = json['activity_summary'];
    activityTypeId = json['activity_type_id'];
    activityUserId = json['activity_user_id'];
    carrierId = json['carrier_id'];
    carrierTrackingRef = json['carrier_tracking_ref'];
    if (json["company_id"] != null) {
      companyId = List<dynamic>.from(
          json["company_id"] != null && (json["company_id"] is bool) == false
              ? json["company_id"]
              : []);
    }
    createDate = json['create_date'];
    if (json["create_uid"] != null) {
      createUid = List<dynamic>.from(
          json["create_uid"] != null && (json["create_uid"] is bool) == false
              ? json["create_uid"]
              : []);
    }
    customerId = json['customer_id'];
    if (json["delivery_id"] != null) {
      deliveryId = List<dynamic>.from(
          json["delivery_id"] != null && (json["delivery_id"] is bool) == false
              ? json["delivery_id"]
              : []);
    }
    destinationId = json['destination_id'];
    displayName = json['display_name'];
    id = json['id'];
    lrNumber = json['lr_number'];
    messageAttachmentCount = json['message_attachment_count'];
    if (json["message_channel_ids"] != null) {
      messageChannelIds = List<dynamic>.from(
          json["message_channel_ids"] != null &&
                  (json["message_channel_ids"] is bool) == false
              ? json["message_channel_ids"]
              : []);
    }
    if (json["message_follower_ids"] != null) {
      messageFollowerIds = List<dynamic>.from(
          json["message_follower_ids"] != null &&
                  (json["message_follower_ids"] is bool) == false
              ? json["message_follower_ids"]
              : []);
    }
    messageHasError = json['message_has_error'];
    messageHasErrorCounter = json['message_has_error_counter'];
    if (json["message_ids"] != null) {
      messageIds = List<dynamic>.from(
          json["message_ids"] != null && (json["message_ids"] is bool) == false
              ? json["message_ids"]
              : []);
    }
    messageIsFollower = json['message_is_follower'];
    messageMainAttachmentId = json['message_main_attachment_id'];
    messageNeedaction = json['message_needaction'];
    messageNeedactionCounter = json['message_needaction_counter'];
    if (json["message_partner_ids"] != null) {
      messagePartnerIds = List<dynamic>.from(
          json["message_partner_ids"] != null &&
                  (json["message_partner_ids"] is bool) == false
              ? json["message_partner_ids"]
              : []);
    }
    messageUnread = json['message_unread'];
    messageUnreadCounter = json['message_unread_counter'];
    name = json['name'];
    noOfParcel = json['no_of_parcel'];
    note = json['note'];
    numberOfPackages = json['number_of_packages'];
    if (json["picking_route_ids"] != null) {
      pickingRouteIds = List<dynamic>.from(json["picking_route_ids"] != null &&
              (json["picking_route_ids"] is bool) == false
          ? json["picking_route_ids"]
          : []);
    }
    if (json["saleorder_id"] != null) {
      saleorderId = List<dynamic>.from(json["saleorder_id"] != null &&
              (json["saleorder_id"] is bool) == false
          ? json["saleorder_id"]
          : []);
    }
    shippingWeight = json['shipping_weight'];
    state = json['state'];
    transportDate = json['transport_date'];
    if (json["transporter_id"] != null) {
      transporterId = List<dynamic>.from(json["transporter_id"] != null &&
              (json["transporter_id"] is bool) == false
          ? json["transporter_id"]
          : []);
    }
    if (json["user_id"] != null) {
      userId = List<dynamic>.from(
          json["user_id"] != null && (json["user_id"] is bool) == false
              ? json["user_id"]
              : []);
    }
    if (json["vehicle_driver"] != null) {
      vehicleDriver = List<dynamic>.from(json["vehicle_driver"] != null &&
              (json["vehicle_driver"] is bool) == false
          ? json["vehicle_driver"]
          : []);
    }
    vehicleId = json['vehicle_id'];
    if (json["website_message_ids"] != null) {
      websiteMessageIds = List<dynamic>.from(
          json["website_message_ids"] != null &&
                  (json["website_message_ids"] is bool) == false
              ? json["website_message_ids"]
              : []);
    }
    weight = json['weight'];
    weightUomId = json['weight_uom_id'];
    writeDate = json['write_date'];
    if (json["write_uid"] != null) {
      writeUid = List<dynamic>.from(
          json["write_uid"] != null && (json["write_uid"] is bool) == false
              ? json["write_uid"]
              : []);
    }
    xTime = json['x_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['__last_update'] = this.sLastUpdate;
    // data['access_token'] = this.accessToken;
    // data['access_url'] = this.accessUrl;
    // data['access_warning'] = this.accessWarning;
    // data['activity_date_deadline'] = this.activityDateDeadline;
    // data['activity_ids'] = this.activityIds;
    // data['activity_state'] = this.activityState;
    // data['activity_summary'] = this.activitySummary;
    // data['activity_type_id'] = this.activityTypeId;
    // data['activity_user_id'] = this.activityUserId;
    // data['carrier_id'] = this.carrierId;
    // data['carrier_tracking_ref'] = this.carrierTrackingRef;
    // data['company_id'] = this.companyId;
    // data['create_date'] = this.createDate;
    // data['create_uid'] = this.createUid;
    // data['customer_id'] = this.customerId;
    // data['delivery_id'] = this.deliveryId;
    // data['destination_id'] = this.destinationId;
    // data['display_name'] = this.displayName;
    data['id'] = this.id;
    // data['lr_number'] = this.lrNumber;
    // data['message_attachment_count'] = this.messageAttachmentCount;
    // data['message_channel_ids'] = this.messageChannelIds;
    // data['message_follower_ids'] = this.messageFollowerIds;
    // data['message_has_error'] = this.messageHasError;
    // data['message_has_error_counter'] = this.messageHasErrorCounter;
    // data['message_ids'] = this.messageIds;
    // data['message_is_follower'] = this.messageIsFollower;
    // data['message_main_attachment_id'] = this.messageMainAttachmentId;
    // data['message_needaction'] = this.messageNeedaction;
    // data['message_needaction_counter'] = this.messageNeedactionCounter;
    // data['message_partner_ids'] = this.messagePartnerIds;
    // data['message_unread'] = this.messageUnread;
    // data['message_unread_counter'] = this.messageUnreadCounter;
    // data['name'] = this.name;
    // data['no_of_parcel'] = this.noOfParcel;
    if (this.note != null) data['note'] = this.note;
    // data['number_of_packages'] = this.numberOfPackages;
    // data['picking_route_ids'] = this.pickingRouteIds;
    // data['saleorder_id'] = this.saleorderId;
    // data['shipping_weight'] = this.shippingWeight;
    data['state'] = this.state;
    // data['transport_date'] = this.transportDate;
    // data['transporter_id'] = this.transporterId;
    // data['user_id'] = this.userId;
    // data['vehicle_driver'] = this.vehicleDriver;
    // data['vehicle_id'] = this.vehicleId;
    // data['website_message_ids'] = this.websiteMessageIds;
    // data['weight'] = this.weight;
    // data['weight_uom_id'] = this.weightUomId;
    // data['write_date'] = this.writeDate;
    // data['write_uid'] = this.writeUid;
    // data['x_time'] = this.xTime;
    return data;
  }
}
