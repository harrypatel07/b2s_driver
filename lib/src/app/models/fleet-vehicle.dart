class FleetVehicle {
  dynamic sLastUpdate;
  dynamic acquisitionDate;
  dynamic active;
  dynamic activityDateDeadline;
  List<dynamic> activityIds;
  dynamic activityState;
  dynamic activitySummary;
  dynamic activityTypeId;
  dynamic activityUserId;
  List<dynamic> brandId;
  dynamic carValue;
  dynamic co2;
  dynamic color;
  dynamic companyId;
  dynamic contractCount;
  dynamic contractRenewalDueSoon;
  dynamic contractRenewalName;
  dynamic contractRenewalOverdue;
  dynamic contractRenewalTotal;
  dynamic costCount;
  dynamic createDate;
  List<dynamic> createUid;
  dynamic displayName;
  dynamic doors;
  List<dynamic> driverId;
  dynamic firstContractDate;
  dynamic fuelLogsCount;
  dynamic fuelType;
  dynamic horsepower;
  dynamic horsepowerTax;
  dynamic id;
  dynamic image;
  dynamic imageMedium;
  dynamic imageSmall;
  dynamic licensePlate;
  dynamic location;
  List<dynamic> logContracts;
  List<dynamic> logDrivers;
  List<dynamic> logFuel;
  List<dynamic> logServices;
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
  List<dynamic> modelId;
  dynamic modelYear;
  dynamic name;
  dynamic odometer;
  dynamic odometerCount;
  dynamic odometerUnit;
  dynamic power;
  dynamic residualValue;
  dynamic seats;
  dynamic serviceCount;
  List<dynamic> stateId;
  List<dynamic> tagIds;
  dynamic transmission;
  List<dynamic> transporterId;
  dynamic vinSn;
  List<dynamic> websiteMessageIds;
  dynamic writeDate;
  List<dynamic> writeUid;
  List<dynamic> xManagerShuttle;

  FleetVehicle(
      {this.sLastUpdate,
      this.acquisitionDate,
      this.active,
      this.activityDateDeadline,
      this.activityIds,
      this.activityState,
      this.activitySummary,
      this.activityTypeId,
      this.activityUserId,
      this.brandId,
      this.carValue,
      this.co2,
      this.color,
      this.companyId,
      this.contractCount,
      this.contractRenewalDueSoon,
      this.contractRenewalName,
      this.contractRenewalOverdue,
      this.contractRenewalTotal,
      this.costCount,
      this.createDate,
      this.createUid,
      this.displayName,
      this.doors,
      this.driverId,
      this.firstContractDate,
      this.fuelLogsCount,
      this.fuelType,
      this.horsepower,
      this.horsepowerTax,
      this.id,
      this.image,
      this.imageMedium,
      this.imageSmall,
      this.licensePlate,
      this.location,
      this.logContracts,
      this.logDrivers,
      this.logFuel,
      this.logServices,
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
      this.modelId,
      this.modelYear,
      this.name,
      this.odometer,
      this.odometerCount,
      this.odometerUnit,
      this.power,
      this.residualValue,
      this.seats,
      this.serviceCount,
      this.stateId,
      this.tagIds,
      this.transmission,
      this.transporterId,
      this.vinSn,
      this.websiteMessageIds,
      this.writeDate,
      this.writeUid,
      this.xManagerShuttle});

  FleetVehicle.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    acquisitionDate = json['acquisition_date'];
    active = json['active'];
    activityDateDeadline = json['activity_date_deadline'];
    activityIds = json['activity_ids'];
    activityState = json['activity_state'];
    activitySummary = json['activity_summary'];
    activityTypeId = json['activity_type_id'];
    activityUserId = json['activity_user_id'];
    brandId = json['brand_id'];
    carValue = json['car_value'];
    co2 = json['co2'];
    color = json['color'];
    companyId = json['company_id'];
    contractCount = json['contract_count'];
    contractRenewalDueSoon = json['contract_renewal_due_soon'];
    contractRenewalName = json['contract_renewal_name'];
    contractRenewalOverdue = json['contract_renewal_overdue'];
    contractRenewalTotal = json['contract_renewal_total'];
    costCount = json['cost_count'];
    createDate = json['create_date'];
    createUid = json['create_uid'];
    displayName = json['display_name'];
    doors = json['doors'];
    driverId = json['driver_id'];
    firstContractDate = json['first_contract_date'];
    fuelLogsCount = json['fuel_logs_count'];
    fuelType = json['fuel_type'];
    horsepower = json['horsepower'];
    horsepowerTax = json['horsepower_tax'];
    id = json['id'];
    image = json['image'];
    imageMedium = json['image_medium'];
    imageSmall = json['image_small'];
    licensePlate = json['license_plate'];
    location = json['location'];
    logContracts = json['log_contracts'];
    logDrivers = json['log_drivers'];
    logFuel = json['log_fuel'];
    logServices = json['log_services'];
    messageAttachmentCount = json['message_attachment_count'];
    messageChannelIds = json['message_channel_ids'];
    messageFollowerIds = json['message_follower_ids'];
    messageHasError = json['message_has_error'];
    messageHasErrorCounter = json['message_has_error_counter'];
    messageIds = json['message_ids'];
    messageIsFollower = json['message_is_follower'];
    messageMainAttachmentId = json['message_main_attachment_id'];
    messageNeedaction = json['message_needaction'];
    messageNeedactionCounter = json['message_needaction_counter'];
    messagePartnerIds = json['message_partner_ids'];
    messageUnread = json['message_unread'];
    messageUnreadCounter = json['message_unread_counter'];
    modelId = json['model_id'];
    modelYear = json['model_year'];
    name = json['name'] != null
        ? json['name'].toString().split('/').last
        : json['name'];
    odometer = json['odometer'];
    odometerCount = json['odometer_count'];
    odometerUnit = json['odometer_unit'];
    power = json['power'];
    residualValue = json['residual_value'];
    seats = json['seats'];
    serviceCount = json['service_count'];
    stateId = json['state_id'];
    tagIds = json['tag_ids'];
    transmission = json['transmission'];
    transporterId = json['transporter_id'];
    vinSn = json['vin_sn'];
    websiteMessageIds = json['website_message_ids'];
    writeDate = json['write_date'];
    writeUid = json['write_uid'];
    xManagerShuttle = json['x_manager_shuttle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__last_update'] = this.sLastUpdate;
    data['acquisition_date'] = this.acquisitionDate;
    data['active'] = this.active;
    data['activity_date_deadline'] = this.activityDateDeadline;
    data['activity_ids'] = this.activityIds;
    data['activity_state'] = this.activityState;
    data['activity_summary'] = this.activitySummary;
    data['activity_type_id'] = this.activityTypeId;
    data['activity_user_id'] = this.activityUserId;
    data['brand_id'] = this.brandId;
    data['car_value'] = this.carValue;
    data['co2'] = this.co2;
    data['color'] = this.color;
    data['company_id'] = this.companyId;
    data['contract_count'] = this.contractCount;
    data['contract_renewal_due_soon'] = this.contractRenewalDueSoon;
    data['contract_renewal_name'] = this.contractRenewalName;
    data['contract_renewal_overdue'] = this.contractRenewalOverdue;
    data['contract_renewal_total'] = this.contractRenewalTotal;
    data['cost_count'] = this.costCount;
    data['create_date'] = this.createDate;
    data['create_uid'] = this.createUid;
    data['display_name'] = this.displayName;
    data['doors'] = this.doors;
    data['driver_id'] = this.driverId;
    data['first_contract_date'] = this.firstContractDate;
    data['fuel_logs_count'] = this.fuelLogsCount;
    data['fuel_type'] = this.fuelType;
    data['horsepower'] = this.horsepower;
    data['horsepower_tax'] = this.horsepowerTax;
    data['id'] = this.id;
    data['image'] = this.image;
    data['image_medium'] = this.imageMedium;
    data['image_small'] = this.imageSmall;
    data['license_plate'] = this.licensePlate;
    data['location'] = this.location;
    data['log_contracts'] = this.logContracts;
    data['log_drivers'] = this.logDrivers;
    data['log_fuel'] = this.logFuel;
    data['log_services'] = this.logServices;
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
    data['model_id'] = this.modelId;
    data['model_year'] = this.modelYear;
    data['name'] = this.name;
    data['odometer'] = this.odometer;
    data['odometer_count'] = this.odometerCount;
    data['odometer_unit'] = this.odometerUnit;
    data['power'] = this.power;
    data['residual_value'] = this.residualValue;
    data['seats'] = this.seats;
    data['service_count'] = this.serviceCount;
    data['state_id'] = this.stateId;
    data['tag_ids'] = this.tagIds;
    data['transmission'] = this.transmission;
    data['transporter_id'] = this.transporterId;
    data['vin_sn'] = this.vinSn;
    data['website_message_ids'] = this.websiteMessageIds;
    data['write_date'] = this.writeDate;
    data['write_uid'] = this.writeUid;
    data['x_manager_shuttle'] = this.xManagerShuttle;
    return data;
  }
}
