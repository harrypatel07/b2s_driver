class StockPicking {
  dynamic sLastUpdate;
  dynamic activityDateDeadline;
  List<dynamic> activityIds;
  dynamic activityState;
  dynamic activitySummary;
  dynamic activityTypeId;
  dynamic activityUserId;
  dynamic backorderId;
  List<dynamic> backorderIds;
  dynamic carrierId;
  dynamic carrierPrice;
  dynamic carrierTrackingRef;
  dynamic carrierTrackingUrl;
  List<dynamic> companyId;
  dynamic createDate;
  List<dynamic> createUid;
  dynamic date;
  dynamic dateDone;
  dynamic deliveryType;
  dynamic displayName;
  List<dynamic> groupId;
  dynamic hasPackages;
  dynamic hasScrapMove;
  dynamic hasTracking;
  dynamic id;
  dynamic immediateTransfer;
  dynamic isLocked;
  List<dynamic> locationDestId;
  List<dynamic> locationId;
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
  List<dynamic> moveIdsWithoutPackage;
  dynamic moveLineExist;
  List<dynamic> moveLineIds;
  List<dynamic> moveLineIdsWithoutPackage;
  List<dynamic> moveLines;
  dynamic moveType;
  dynamic name;
  dynamic noOfParcel;
  dynamic note;
  dynamic numberOfPackages;
  dynamic origin;
  dynamic ownerId;
  List<dynamic> packageIds;
  List<dynamic> packageLevelIds;
  List<dynamic> packageLevelIdsDetails;
  List<dynamic> partnerId;
  List<dynamic> pickingRouteIds;
  dynamic pickingTransportCount;
  List<dynamic> pickingTransportIds;
  dynamic pickingTypeCode;
  dynamic pickingTypeEntirePacks;
  List<dynamic> pickingTypeId;
  dynamic printed;
  dynamic priority;
  List<dynamic> productId;
  dynamic saleId;
  dynamic scheduledDate;
  dynamic shippingWeight;
  dynamic showCheckAvailability;
  dynamic showLotsText;
  dynamic showMarkAsTodo;
  dynamic showOperations;
  dynamic showValidate;
  dynamic state;
  dynamic transportDate;
  List<dynamic> transporterId;
  dynamic transporterRouteId;
  List<dynamic> vehicleDriver;
  List<dynamic> vehicleId;
  dynamic volume;
  dynamic websiteId;
  List<dynamic> websiteMessageIds;
  dynamic weight;
  dynamic weightBulk;
  List<dynamic> weightUomId;
  dynamic writeDate;
  List<dynamic> writeUid;

  StockPicking(
      {this.sLastUpdate,
      this.activityDateDeadline,
      this.activityIds,
      this.activityState,
      this.activitySummary,
      this.activityTypeId,
      this.activityUserId,
      this.backorderId,
      this.backorderIds,
      this.carrierId,
      this.carrierPrice,
      this.carrierTrackingRef,
      this.carrierTrackingUrl,
      this.companyId,
      this.createDate,
      this.createUid,
      this.date,
      this.dateDone,
      this.deliveryType,
      this.displayName,
      this.groupId,
      this.hasPackages,
      this.hasScrapMove,
      this.hasTracking,
      this.id,
      this.immediateTransfer,
      this.isLocked,
      this.locationDestId,
      this.locationId,
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
      this.moveIdsWithoutPackage,
      this.moveLineExist,
      this.moveLineIds,
      this.moveLineIdsWithoutPackage,
      this.moveLines,
      this.moveType,
      this.name,
      this.noOfParcel,
      this.note,
      this.numberOfPackages,
      this.origin,
      this.ownerId,
      this.packageIds,
      this.packageLevelIds,
      this.packageLevelIdsDetails,
      this.partnerId,
      this.pickingRouteIds,
      this.pickingTransportCount,
      this.pickingTransportIds,
      this.pickingTypeCode,
      this.pickingTypeEntirePacks,
      this.pickingTypeId,
      this.printed,
      this.priority,
      this.productId,
      this.saleId,
      this.scheduledDate,
      this.shippingWeight,
      this.showCheckAvailability,
      this.showLotsText,
      this.showMarkAsTodo,
      this.showOperations,
      this.showValidate,
      this.state,
      this.transportDate,
      this.transporterId,
      this.transporterRouteId,
      this.vehicleDriver,
      this.vehicleId,
      this.volume,
      this.websiteId,
      this.websiteMessageIds,
      this.weight,
      this.weightBulk,
      this.weightUomId,
      this.writeDate,
      this.writeUid});

  StockPicking.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
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
    backorderId = json['backorder_id'];
    if (json["backorder_ids"] != null) {
      backorderIds = List<dynamic>.from(json["backorder_ids"] != null &&
              (json["backorder_ids"] is bool) == false
          ? json["backorder_ids"]
          : []);
    }
    carrierId = json['carrier_id'];
    carrierPrice = json['carrier_price'];
    carrierTrackingRef = json['carrier_tracking_ref'];
    carrierTrackingUrl = json['carrier_tracking_url'];
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
    date = json['date'];
    dateDone = json['date_done'];
    deliveryType = json['delivery_type'];
    displayName = json['display_name'];
    if (json["group_id"] != null) {
      groupId = List<dynamic>.from(
          json["group_id"] != null && (json["group_id"] is bool) == false
              ? json["group_id"]
              : []);
    }
    hasPackages = json['has_packages'];
    hasScrapMove = json['has_scrap_move'];
    hasTracking = json['has_tracking'];
    id = json['id'];
    immediateTransfer = json['immediate_transfer'];
    isLocked = json['is_locked'];
    if (json["location_dest_id"] != null) {
      locationDestId = List<dynamic>.from(json["location_dest_id"] != null &&
              (json["location_dest_id"] is bool) == false
          ? json["location_dest_id"]
          : []);
    }
    if (json["location_id"] != null) {
      locationId = List<dynamic>.from(
          json["location_id"] != null && (json["location_id"] is bool) == false
              ? json["location_id"]
              : []);
    }
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
    if (json["move_ids_without_package"] != null) {
      moveIdsWithoutPackage = List<dynamic>.from(
          json["move_ids_without_package"] != null &&
                  (json["move_ids_without_package"] is bool) == false
              ? json["move_ids_without_package"]
              : []);
    }
    moveLineExist = json['move_line_exist'];
    if (json["move_line_ids"] != null) {
      moveLineIds = List<dynamic>.from(json["move_line_ids"] != null &&
              (json["move_line_ids"] is bool) == false
          ? json["move_line_ids"]
          : []);
    }
    if (json["move_line_ids_without_package"] != null) {
      moveLineIdsWithoutPackage = List<dynamic>.from(
          json["move_line_ids_without_package"] != null &&
                  (json["move_line_ids_without_package"] is bool) == false
              ? json["move_line_ids_without_package"]
              : []);
    }
    if (json["move_lines"] != null) {
      moveLines = List<dynamic>.from(
          json["move_lines"] != null && (json["move_lines"] is bool) == false
              ? json["move_lines"]
              : []);
    }
    moveType = json['move_type'];
    name = json['name'];
    noOfParcel = json['no_of_parcel'];
    note = json['note'];
    numberOfPackages = json['number_of_packages'];
    origin = json['origin'];
    ownerId = json['owner_id'];
    if (json["package_ids"] != null) {
      packageIds = List<dynamic>.from(
          json["package_ids"] != null && (json["package_ids"] is bool) == false
              ? json["package_ids"]
              : []);
    }
    if (json["package_level_ids"] != null) {
      packageLevelIds = List<dynamic>.from(json["package_level_ids"] != null &&
              (json["package_level_ids"] is bool) == false
          ? json["package_level_ids"]
          : []);
    }
    if (json["package_level_ids_details"] != null) {
      packageLevelIdsDetails = List<dynamic>.from(
          json["package_level_ids_details"] != null &&
                  (json["package_level_ids_details"] is bool) == false
              ? json["package_level_ids_details"]
              : []);
    }
    if (json["partner_id"] != null) {
      partnerId = List<dynamic>.from(
          json["partner_id"] != null && (json["partner_id"] is bool) == false
              ? json["partner_id"]
              : []);
    }
    if (json["picking_route_ids"] != null) {
      pickingRouteIds = List<dynamic>.from(json["picking_route_ids"] != null &&
              (json["picking_route_ids"] is bool) == false
          ? json["picking_route_ids"]
          : []);
    }
    pickingTransportCount = json['picking_transport_count'];
    if (json["picking_transport_ids"] != null) {
      pickingTransportIds = List<dynamic>.from(
          json["picking_transport_ids"] != null &&
                  (json["picking_transport_ids"] is bool) == false
              ? json["picking_transport_ids"]
              : []);
    }
    pickingTypeCode = json['picking_type_code'];
    pickingTypeEntirePacks = json['picking_type_entire_packs'];
    if (json["picking_type_id"] != null) {
      pickingTypeId = List<dynamic>.from(json["picking_type_id"] != null &&
              (json["picking_type_id"] is bool) == false
          ? json["picking_type_id"]
          : []);
    }
    printed = json['printed'];
    priority = json['priority'];
    if (json["product_id"] != null) {
      productId = List<dynamic>.from(
          json["product_id"] != null && (json["product_id"] is bool) == false
              ? json["product_id"]
              : []);
    }
    saleId = json['sale_id'];
    scheduledDate = json['scheduled_date'];
    shippingWeight = json['shipping_weight'];
    showCheckAvailability = json['show_check_availability'];
    showLotsText = json['show_lots_text'];
    showMarkAsTodo = json['show_mark_as_todo'];
    showOperations = json['show_operations'];
    showValidate = json['show_validate'];
    state = json['state'];
    transportDate = json['transport_date'];
    if (json["transporter_id"] != null) {
      transporterId = List<dynamic>.from(json["transporter_id"] != null &&
              (json["transporter_id"] is bool) == false
          ? json["transporter_id"]
          : []);
    }
    transporterRouteId = json['transporter_route_id'];
    if (json["vehicle_driver"] != null) {
      vehicleDriver = List<dynamic>.from(json["vehicle_driver"] != null &&
              (json["vehicle_driver"] is bool) == false
          ? json["vehicle_driver"]
          : []);
    }
    if (json["vehicle_id"] != null) {
      vehicleId = List<dynamic>.from(
          json["vehicle_id"] != null && (json["vehicle_id"] is bool) == false
              ? json["vehicle_id"]
              : []);
    }
    volume = json['volume'];
    websiteId = json['website_id'];
    if (json["website_message_ids"] != null) {
      websiteMessageIds = List<dynamic>.from(
          json["website_message_ids"] != null &&
                  (json["website_message_ids"] is bool) == false
              ? json["website_message_ids"]
              : []);
    }
    weight = json['weight'];
    weightBulk = json['weight_bulk'];
    if (json["weight_uom_id"] != null) {
      weightUomId = List<dynamic>.from(json["weight_uom_id"] != null &&
              (json["weight_uom_id"] is bool) == false
          ? json["weight_uom_id"]
          : []);
    }
    writeDate = json['write_date'];
    if (json["write_uid"] != null) {
      writeUid = List<dynamic>.from(
          json["write_uid"] != null && (json["write_uid"] is bool) == false
              ? json["write_uid"]
              : []);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__last_update'] = this.sLastUpdate;
    data['activity_date_deadline'] = this.activityDateDeadline;
    data['activity_ids'] = this.activityIds;
    data['activity_state'] = this.activityState;
    data['activity_summary'] = this.activitySummary;
    data['activity_type_id'] = this.activityTypeId;
    data['activity_user_id'] = this.activityUserId;
    data['backorder_id'] = this.backorderId;
    data['backorder_ids'] = this.backorderIds;
    data['carrier_id'] = this.carrierId;
    data['carrier_price'] = this.carrierPrice;
    data['carrier_tracking_ref'] = this.carrierTrackingRef;
    data['carrier_tracking_url'] = this.carrierTrackingUrl;
    data['company_id'] = this.companyId;
    data['create_date'] = this.createDate;
    data['create_uid'] = this.createUid;
    data['date'] = this.date;
    data['date_done'] = this.dateDone;
    data['delivery_type'] = this.deliveryType;
    data['display_name'] = this.displayName;
    data['group_id'] = this.groupId;
    data['has_packages'] = this.hasPackages;
    data['has_scrap_move'] = this.hasScrapMove;
    data['has_tracking'] = this.hasTracking;
    data['id'] = this.id;
    data['immediate_transfer'] = this.immediateTransfer;
    data['is_locked'] = this.isLocked;
    data['location_dest_id'] = this.locationDestId;
    data['location_id'] = this.locationId;
    data['lr_number'] = this.lrNumber;
    data['message_attachment_count'] = this.messageAttachmentCount;
    data['message_channel_ids'] = this.messageChannelIds;
    data['message_follower_ids'] = this.messageFollowerIds;
    data['message_has_error'] = this.messageHasError;
    data['message_has_error_counter'] = this.messageHasErrorCounter;
    data['message_ids'] = this.messageIds;
    data['message_is_follower'] = this.messageIsFollower;
    data['message_main_attachment_id'] = this.messageMainAttachmentId;
    data['message_needaction'] = this.messageNeedaction;
    data['message_needaction_counter'] = this.messageNeedactionCounter;
    data['message_partner_ids'] = this.messagePartnerIds;
    data['message_unread'] = this.messageUnread;
    data['message_unread_counter'] = this.messageUnreadCounter;
    data['move_ids_without_package'] = this.moveIdsWithoutPackage;
    data['move_line_exist'] = this.moveLineExist;
    data['move_line_ids'] = this.moveLineIds;
    data['move_line_ids_without_package'] = this.moveLineIdsWithoutPackage;
    data['move_lines'] = this.moveLines;
    data['move_type'] = this.moveType;
    data['name'] = this.name;
    data['no_of_parcel'] = this.noOfParcel;
    data['note'] = this.note;
    data['number_of_packages'] = this.numberOfPackages;
    data['origin'] = this.origin;
    data['owner_id'] = this.ownerId;
    data['package_ids'] = this.packageIds;
    data['package_level_ids'] = this.packageLevelIds;
    data['package_level_ids_details'] = this.packageLevelIdsDetails;
    data['partner_id'] = this.partnerId;
    data['picking_route_ids'] = this.pickingRouteIds;
    data['picking_transport_count'] = this.pickingTransportCount;
    data['picking_transport_ids'] = this.pickingTransportIds;
    data['picking_type_code'] = this.pickingTypeCode;
    data['picking_type_entire_packs'] = this.pickingTypeEntirePacks;
    data['picking_type_id'] = this.pickingTypeId;
    data['printed'] = this.printed;
    data['priority'] = this.priority;
    data['product_id'] = this.productId;
    data['sale_id'] = this.saleId;
    data['scheduled_date'] = this.scheduledDate;
    data['shipping_weight'] = this.shippingWeight;
    data['show_check_availability'] = this.showCheckAvailability;
    data['show_lots_text'] = this.showLotsText;
    data['show_mark_as_todo'] = this.showMarkAsTodo;
    data['show_operations'] = this.showOperations;
    data['show_validate'] = this.showValidate;
    data['state'] = this.state;
    data['transport_date'] = this.transportDate;
    data['transporter_id'] = this.transporterId;
    data['transporter_route_id'] = this.transporterRouteId;
    data['vehicle_driver'] = this.vehicleDriver;
    data['vehicle_id'] = this.vehicleId;
    data['volume'] = this.volume;
    data['website_id'] = this.websiteId;
    data['website_message_ids'] = this.websiteMessageIds;
    data['weight'] = this.weight;
    data['weight_bulk'] = this.weightBulk;
    data['weight_uom_id'] = this.weightUomId;
    data['write_date'] = this.writeDate;
    data['write_uid'] = this.writeUid;
    return data;
  }
}
