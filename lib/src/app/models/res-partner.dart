import 'dart:convert';
import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/parent.dart';

class ResPartner {
  dynamic sLastUpdate;
  dynamic active;
  dynamic activityDateDeadline;
  List<dynamic> activityIds;
  dynamic activityState;
  dynamic activitySummary;
  dynamic activityTypeId;
  dynamic activityUserId;
  dynamic additionalInfo;
  dynamic bankAccountCount;
  List<dynamic> bankIds;
  dynamic barcode;
  dynamic calendarLastNotifAck;
  List<dynamic> categoryId;
  List<dynamic> channelIds;
  List<dynamic> childIds;
  dynamic city;
  dynamic color;
  dynamic comment;
  dynamic commercialCompanyName;
  List<dynamic> commercialPartnerId;
  List<dynamic> companyId;
  dynamic companyName;
  dynamic companyType;
  dynamic contactAddress;
  List<dynamic> contractIds;
  dynamic contractsCount;
  dynamic countryId;
  dynamic createDate;
  List<dynamic> createUid;
  dynamic credit;
  dynamic creditLimit;
  List<dynamic> currencyId;
  dynamic customer;
  dynamic date;
  dynamic debit;
  dynamic debitLimit;
  dynamic displayName;
  dynamic email;
  dynamic emailFormatted;
  dynamic employee;
  dynamic eventCount;
  dynamic function;
  dynamic hasUnreconciledEntries;
  dynamic id;
  dynamic imStatus;
  dynamic image;
  dynamic imageMedium;
  dynamic imageSmall;
  dynamic industryId;
  List<dynamic> invoiceIds;
  dynamic invoiceWarn;
  dynamic invoiceWarnMsg;
  dynamic isBlacklisted;
  dynamic isCompany;
  dynamic isPublished;
  dynamic isSeoOptimized;
  dynamic journalItemCount;
  dynamic lang;
  dynamic lastTimeEntriesChecked;
  dynamic lastWebsiteSoId;
  dynamic meetingCount;
  List<dynamic> meetingIds;
  dynamic messageAttachmentCount;
  dynamic messageBounce;
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
  dynamic mobile;
  dynamic name;
  dynamic opportunityCount;
  List<dynamic> opportunityIds;
  dynamic parentId;
  dynamic parentName;
  dynamic partnerGid;
  dynamic partnerShare;
  dynamic paymentTokenCount;
  List<dynamic> paymentTokenIds;
  dynamic phone;
  dynamic pickingWarn;
  dynamic pickingWarnMsg;
  List<dynamic> propertyAccountPayableId;
  dynamic propertyAccountPositionId;
  List<dynamic> propertyAccountReceivableId;
  dynamic propertyDeliveryCarrierId;
  dynamic propertyPaymentTermId;
  List<dynamic> propertyProductPricelist;
  List<dynamic> propertyStockCustomer;
  List<dynamic> propertyStockSupplier;
  dynamic propertySupplierPaymentTermId;
  dynamic ref;
  List<dynamic> refCompanyIds;
  dynamic saleOrderCount;
  List<dynamic> saleOrderIds;
  dynamic saleWarn;
  dynamic saleWarnMsg;
  List<dynamic> self;
  dynamic signupExpiration;
  dynamic signupToken;
  dynamic signupType;
  dynamic signupUrl;
  dynamic signupValid;
  dynamic stateId;
  dynamic street;
  dynamic street2;
  dynamic supplier;
  dynamic teamId;
  dynamic title;
  dynamic totalInvoiced;
  dynamic trust;
  dynamic type;
  dynamic tz;
  dynamic tzOffset;
  dynamic userId;
  List<dynamic> userIds;
  dynamic vat;
  dynamic vehicleCount;
  List<dynamic> vehicleIds;
  dynamic website;
  dynamic websiteDescription;
  dynamic websiteId;
  List<dynamic> websiteMessageIds;
  dynamic websiteMetaDescription;
  dynamic websiteMetaKeywords;
  dynamic websiteMetaOgImg;
  dynamic websiteMetaTitle;
  dynamic websitePublished;
  dynamic websiteShortDescription;
  dynamic websiteUrl;
  List<dynamic> wishlistIds;
  dynamic writeDate;
  List<dynamic> writeUid;
  dynamic zip;
  dynamic xClass;
  dynamic xSchool;
  dynamic wkDob;
  dynamic xQrCode;
  dynamic xQrCodeImg;
  ResPartner({
    this.sLastUpdate,
    this.active,
    this.activityDateDeadline,
    this.activityIds,
    this.activityState,
    this.activitySummary,
    this.activityTypeId,
    this.activityUserId,
    this.additionalInfo,
    this.bankAccountCount,
    this.bankIds,
    this.barcode,
    this.calendarLastNotifAck,
    this.categoryId,
    this.channelIds,
    this.childIds,
    this.city,
    this.color,
    this.comment,
    this.commercialCompanyName,
    this.commercialPartnerId,
    this.companyId,
    this.companyName,
    this.companyType,
    this.contactAddress,
    this.contractIds,
    this.contractsCount,
    this.countryId,
    this.createDate,
    this.createUid,
    this.credit,
    this.creditLimit,
    this.currencyId,
    this.customer,
    this.date,
    this.debit,
    this.debitLimit,
    this.displayName,
    this.email,
    this.emailFormatted,
    this.employee,
    this.eventCount,
    this.function,
    this.hasUnreconciledEntries,
    this.id,
    this.imStatus,
    this.image,
    this.imageMedium,
    this.imageSmall,
    this.industryId,
    this.invoiceIds,
    this.invoiceWarn,
    this.invoiceWarnMsg,
    this.isBlacklisted,
    this.isCompany,
    this.isPublished,
    this.isSeoOptimized,
    this.journalItemCount,
    this.lang,
    this.lastTimeEntriesChecked,
    this.lastWebsiteSoId,
    this.meetingCount,
    this.meetingIds,
    this.messageAttachmentCount,
    this.messageBounce,
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
    this.mobile,
    this.name,
    this.opportunityCount,
    this.opportunityIds,
    this.parentId,
    this.parentName,
    this.partnerGid,
    this.partnerShare,
    this.paymentTokenCount,
    this.paymentTokenIds,
    this.phone,
    this.pickingWarn,
    this.pickingWarnMsg,
    this.propertyAccountPayableId,
    this.propertyAccountPositionId,
    this.propertyAccountReceivableId,
    this.propertyDeliveryCarrierId,
    this.propertyPaymentTermId,
    this.propertyProductPricelist,
    this.propertyStockCustomer,
    this.propertyStockSupplier,
    this.propertySupplierPaymentTermId,
    this.ref,
    this.refCompanyIds,
    this.saleOrderCount,
    this.saleOrderIds,
    this.saleWarn,
    this.saleWarnMsg,
    this.self,
    this.signupExpiration,
    this.signupToken,
    this.signupType,
    this.signupUrl,
    this.signupValid,
    this.stateId,
    this.street,
    this.street2,
    this.supplier,
    this.teamId,
    this.title,
    this.totalInvoiced,
    this.trust,
    this.type,
    this.tz,
    this.tzOffset,
    this.userId,
    this.userIds,
    this.vat,
    this.vehicleCount,
    this.vehicleIds,
    this.website,
    this.websiteDescription,
    this.websiteId,
    this.websiteMessageIds,
    this.websiteMetaDescription,
    this.websiteMetaKeywords,
    this.websiteMetaOgImg,
    this.websiteMetaTitle,
    this.websitePublished,
    this.websiteShortDescription,
    this.websiteUrl,
    this.wishlistIds,
    this.writeDate,
    this.writeUid,
    this.zip,
    this.xClass,
    this.xSchool,
    this.wkDob,
    this.xQrCode,
    this.xQrCodeImg,
  });

  ResPartner.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    active = json['active'];
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
    additionalInfo = json['additional_info'];
    bankAccountCount = json['bank_account_count'];
    if (json["bank_ids"] != null) {
      bankIds = List<dynamic>.from(
          json["bank_ids"] != null && (json["bank_ids"] is bool) == false
              ? json["bank_ids"]
              : []);
    }
    barcode = json['barcode'];
    calendarLastNotifAck = json['calendar_last_notif_ack'];
    if (json["category_id"] != null) {
      categoryId = List<dynamic>.from(
          json["category_id"] != null && (json["category_id"] is bool) == false
              ? json["category_id"]
              : []);
    }
    if (json["channel_ids"] != null) {
      channelIds = List<dynamic>.from(
          json["channel_ids"] != null && (json["channel_ids"] is bool) == false
              ? json["channel_ids"]
              : []);
    }
    if (json["child_ids"] != null) {
      childIds = List<dynamic>.from(
          json["child_ids"] != null && (json["child_ids"] is bool) == false
              ? json["child_ids"]
              : []);
    }
    city = json['city'];
    color = json['color'];
    comment = json['comment'];
    commercialCompanyName = json['commercial_company_name'];
    if (json["commercial_partner_id"] != null) {
      commercialPartnerId = List<dynamic>.from(
          json["commercial_partner_id"] != null &&
                  (json["commercial_partner_id"] is bool) == false
              ? json["commercial_partner_id"]
              : []);
    }
    if (json["company_id"] != null) {
      companyId = List<dynamic>.from(
          json["company_id"] != null && (json["company_id"] is bool) == false
              ? json["company_id"]
              : []);
    }
    companyName = json['company_name'];
    companyType = json['company_type'];
    contactAddress = json['contact_address'];
    if (json["contract_ids"] != null) {
      contractIds = List<dynamic>.from(json["contract_ids"] != null &&
              (json["contract_ids"] is bool) == false
          ? json["contract_ids"]
          : []);
    }
    contractsCount = json['contracts_count'];
    countryId = json['country_id'];
    createDate = json['create_date'];
    if (json["create_uid"] != null) {
      createUid = List<dynamic>.from(
          json["create_uid"] != null && (json["create_uid"] is bool) == false
              ? json["create_uid"]
              : []);
    }
    credit = json['credit'];
    creditLimit = json['credit_limit'];
    if (json["currency_id"] != null) {
      currencyId = List<dynamic>.from(
          json["currency_id"] != null && (json["currency_id"] is bool) == false
              ? json["currency_id"]
              : []);
    }
    customer = json['customer'];
    date = json['date'];
    debit = json['debit'];
    debitLimit = json['debit_limit'];
    displayName = json['display_name'];
    email = json['email'];
    emailFormatted = json['email_formatted'];
    employee = json['employee'];
    eventCount = json['event_count'];
    function = json['function'];
    hasUnreconciledEntries = json['has_unreconciled_entries'];
    id = json['id'];
    imStatus = json['im_status'];
    image =
        "$domainApi/web/image?model=res.partner&field=image&id=$id&${api.sessionId}";
    imageMedium =
        "$domainApi/web/image?model=res.partner&field=imageMedium&id=$id&${api.sessionId}";
    imageSmall =
        "$domainApi/web/image?model=res.partner&field=imageSmall&id=$id&${api.sessionId}";
    // if (json['image'] != null) image = base64.decode(json['image']);
    // if (json['image_medium'] != null)
    //   imageMedium = base64.decode(json['image_medium']);
    // if (json['image_small'] != null)
    //   imageSmall = base64.decode(json['image_small']);
    // industryId = json['industry_id'];
    // if (json["invoice_ids"] != null) {
    //   invoiceIds = List<dynamic>.from(
    //       json["invoice_ids"] != null && (json["invoice_ids"] is bool) == false
    //           ? json["invoice_ids"]
    //           : []);
    // }
    invoiceWarn = json['invoice_warn'];
    invoiceWarnMsg = json['invoice_warn_msg'];
    isBlacklisted = json['is_blacklisted'];
    isCompany = json['is_company'];
    isPublished = json['is_published'];
    isSeoOptimized = json['is_seo_optimized'];
    journalItemCount = json['journal_item_count'];
    lang = json['lang'];
    lastTimeEntriesChecked = json['last_time_entries_checked'];
    lastWebsiteSoId = json['last_website_so_id'];
    meetingCount = json['meeting_count'];
    if (json["meeting_ids"] != null) {
      meetingIds = List<dynamic>.from(
          json["meeting_ids"] != null && (json["meeting_ids"] is bool) == false
              ? json["meeting_ids"]
              : []);
    }
    messageAttachmentCount = json['message_attachment_count'];
    messageBounce = json['message_bounce'];
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
    mobile = json['mobile'];
    name = json['name'];
    opportunityCount = json['opportunity_count'];
    if (json["opportunity_ids"] != null) {
      opportunityIds = List<dynamic>.from(json["opportunity_ids"] != null &&
              (json["opportunity_ids"] is bool) == false
          ? json["opportunity_ids"]
          : []);
    }
    parentId = json['parent_id'];
    parentName = json['parent_name'];
    partnerGid = json['partner_gid'];
    partnerShare = json['partner_share'];
    paymentTokenCount = json['payment_token_count'];
    if (json["payment_token_ids"] != null) {
      paymentTokenIds = List<dynamic>.from(json["payment_token_ids"] != null &&
              (json["payment_token_ids"] is bool) == false
          ? json["payment_token_ids"]
          : []);
    }
    phone = json['phone'];
    pickingWarn = json['picking_warn'];
    pickingWarnMsg = json['picking_warn_msg'];
    if (json["property_account_payable_id"] != null) {
      propertyAccountPayableId = List<dynamic>.from(
          json["property_account_payable_id"] != null &&
                  (json["property_account_payable_id"] is bool) == false
              ? json["property_account_payable_id"]
              : []);
    }
    propertyAccountPositionId = json['property_account_position_id'];
    if (json["property_account_receivable_id"] != null) {
      propertyAccountReceivableId = List<dynamic>.from(
          json["property_account_receivable_id"] != null &&
                  (json["property_account_receivable_id"] is bool) == false
              ? json["property_account_receivable_id"]
              : []);
    }
    propertyDeliveryCarrierId = json['property_delivery_carrier_id'];
    propertyPaymentTermId = json['property_payment_term_id'];
    if (json["property_product_pricelist"] != null) {
      propertyProductPricelist = List<dynamic>.from(
          json["property_product_pricelist"] != null &&
                  (json["property_product_pricelist"] is bool) == false
              ? json["property_product_pricelist"]
              : []);
    }
    if (json["property_stock_customer"] != null) {
      propertyStockCustomer = List<dynamic>.from(
          json["property_stock_customer"] != null &&
                  (json["property_stock_customer"] is bool) == false
              ? json["property_stock_customer"]
              : []);
    }
    if (json["property_stock_supplier"] != null) {
      propertyStockSupplier = List<dynamic>.from(
          json["property_stock_supplier"] != null &&
                  (json["property_stock_supplier"] is bool) == false
              ? json["property_stock_supplier"]
              : []);
    }
    propertySupplierPaymentTermId = json['property_supplier_payment_term_id'];
    ref = json['ref'];
    if (json["ref_company_ids"] != null) {
      refCompanyIds = List<dynamic>.from(json["ref_company_ids"] != null &&
              (json["ref_company_ids"] is bool) == false
          ? json["ref_company_ids"]
          : []);
    }
    saleOrderCount = json['sale_order_count'];
    if (json["sale_order_ids"] != null) {
      saleOrderIds = List<dynamic>.from(json["sale_order_ids"] != null &&
              (json["sale_order_ids"] is bool) == false
          ? json["sale_order_ids"]
          : []);
    }
    saleWarn = json['sale_warn'];
    saleWarnMsg = json['sale_warn_msg'];
    if (json["self"] != null) {
      self = List<dynamic>.from(
          json["self"] != null && (json["self"] is bool) == false
              ? json["self"]
              : []);
    }
    signupExpiration = json['signup_expiration'];
    signupToken = json['signup_token'];
    signupType = json['signup_type'];
    signupUrl = json['signup_url'];
    signupValid = json['signup_valid'];
    stateId = json['state_id'];
    street = json['street'];
    street2 = json['street2'];
    supplier = json['supplier'];
    teamId = json['team_id'];
    title = json['title'];
    totalInvoiced = json['total_invoiced'];
    trust = json['trust'];
    type = json['type'];
    tz = json['tz'];
    tzOffset = json['tz_offset'];
    userId = json['user_id'];
    if (json["user_ids"] != null) {
      userIds = List<dynamic>.from(
          json["user_ids"] != null && (json["user_ids"] is bool) == false
              ? json["user_ids"]
              : []);
    }
    vat = json['vat'];
    vehicleCount = json['vehicle_count'];
    if (json["vehicle_ids"] != null) {
      vehicleIds = List<dynamic>.from(
          json["vehicle_ids"] != null && (json["vehicle_ids"] is bool) == false
              ? json["vehicle_ids"]
              : []);
    }
    website = json['website'];
    websiteDescription = json['website_description'];
    websiteId = json['website_id'];
    if (json["website_message_ids"] != null) {
      websiteMessageIds = List<dynamic>.from(
          json["website_message_ids"] != null &&
                  (json["website_message_ids"] is bool) == false
              ? json["website_message_ids"]
              : []);
    }
    websiteMetaDescription = json['website_meta_description'];
    websiteMetaKeywords = json['website_meta_keywords'];
    websiteMetaOgImg = json['website_meta_og_img'];
    websiteMetaTitle = json['website_meta_title'];
    websitePublished = json['website_published'];
    websiteShortDescription = json['website_short_description'];
    websiteUrl = json['website_url'];
    if (json["wishlist_ids"] != null) {
      wishlistIds = List<dynamic>.from(json["wishlist_ids"] != null &&
              (json["wishlist_ids"] is bool) == false
          ? json["wishlist_ids"]
          : []);
    }
    writeDate = json['write_date'];
    if (json["write_uid"] != null) {
      writeUid = List<dynamic>.from(
          json["write_uid"] != null && (json["write_uid"] is bool) == false
              ? json["write_uid"]
              : []);
    }
    zip = json['zip'];
    xClass = json['x_class'];
    xSchool = json['x_school'];
    wkDob = json['wk_dob'];
    xQrCode = json['x_qr_code'];
  }

  ResPartner.fromChildren(Children children) {
    if (children.id != null) id = children.id;
    name = children.name;
    image = children.photo;
    contactAddress = children.location;
    title = children.genderId;
    email = children.email;
    phone = children.phone;
    parentId = children.parentId;
    xSchool = children.schoolId;
    xClass = children.classes;
    wkDob = children.birthday;
  }

  ResPartner.fromParent(Parent parent) {
    if (parent.id != null) id = parent.id;
    name = parent.name;
    image = parent.photo;
    contactAddress = parent.contactAddress;
    title = parent.genderId;
    email = parent.email;
    phone = parent.phone;
  }
  ResPartner.fromDriver(Driver driver) {
    if (driver.id != null) id = driver.id;
    name = driver.name;
    image = driver.photo;
//    contactAddress = driver.contactAddress;
    title = driver.genderId;
//    email = driver.email;
    phone = driver.phone;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['__last_update'] = this.sLastUpdate;
    // data['active'] = this.active;
    // data['activity_date_deadline'] = this.activityDateDeadline;
    // data['activity_ids'] = this.activityIds;
    // data['activity_state'] = this.activityState;
    // data['activity_summary'] = this.activitySummary;
    // data['activity_type_id'] = this.activityTypeId;
    // data['activity_user_id'] = this.activityUserId;
    // data['additional_info'] = this.additionalInfo;
    // data['bank_account_count'] = this.bankAccountCount;
    // data['bank_ids'] = this.bankIds;
    // data['barcode'] = this.barcode;
    // data['calendar_last_notif_ack'] = this.calendarLastNotifAck;
    // data['category_id'] = this.categoryId;
    // data['channel_ids'] = this.channelIds;
    // data['child_ids'] = this.childIds;
    // data['city'] = this.city;
    // data['color'] = this.color;
    // data['comment'] = this.comment;
    // data['commercial_company_name'] = this.commercialCompanyName;
    // data['commercial_partner_id'] = this.commercialPartnerId;
    // data['company_id'] = this.companyId;
    // data['company_name'] = this.companyName;
    // data['company_type'] = this.companyType;
    data['contact_address'] = this.contactAddress;
    // data['contract_ids'] = this.contractIds;
    // data['contracts_count'] = this.contractsCount;
    // data['country_id'] = this.countryId;
    // data['create_date'] = this.createDate;
    // data['create_uid'] = this.createUid;
    // data['credit'] = this.credit;
    // data['credit_limit'] = this.creditLimit;
    // data['currency_id'] = this.currencyId;
    // data['customer'] = this.customer;
    // data['date'] = this.date;
    // data['debit'] = this.debit;
    // data['debit_limit'] = this.debitLimit;
    // data['display_name'] = this.displayName;
    data['email'] = this.email;
    // data['email_formatted'] = this.emailFormatted;
    // data['employee'] = this.employee;
    // data['event_count'] = this.eventCount;
    // data['function'] = this.function;
    // data['has_unreconciled_entries'] = this.hasUnreconciledEntries;
    if (this.id != null) data['id'] = this.id;
    // data['im_status'] = this.imStatus;
    if (!(this.image is bool)) if (this.image != null) {
      if (this.image is List) data['image'] = base64.encode(this.image);
    }
    // data['image_medium'] = this.imageMedium;
    // data['image_small'] = this.imageSmall;
    // data['industry_id'] = this.industryId;
    // data['invoice_ids'] = this.invoiceIds;
    // data['invoice_warn'] = this.invoiceWarn;
    // data['invoice_warn_msg'] = this.invoiceWarnMsg;
    // data['is_blacklisted'] = this.isBlacklisted;
    // data['is_company'] = this.isCompany;
    // data['is_published'] = this.isPublished;
    // data['is_seo_optimized'] = this.isSeoOptimized;
    // data['journal_item_count'] = this.journalItemCount;
    // data['lang'] = this.lang;
    // data['last_time_entries_checked'] = this.lastTimeEntriesChecked;
    // data['last_website_so_id'] = this.lastWebsiteSoId;
    // data['meeting_count'] = this.meetingCount;
    // data['meeting_ids'] = this.meetingIds;
    // data['message_attachment_count'] = this.messageAttachmentCount;
    // data['message_bounce'] = this.messageBounce;
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
    // data['mobile'] = this.mobile;
    data['name'] = this.name;
    // data['opportunity_count'] = this.opportunityCount;
    // data['opportunity_ids'] = this.opportunityIds;
    if (!(this.parentId is bool)) data['parent_id'] = this.parentId;
    // data['parent_name'] = this.parentName;
    // data['partner_gid'] = this.partnerGid;
    // data['partner_share'] = this.partnerShare;
    // data['payment_token_count'] = this.paymentTokenCount;
    // data['payment_token_ids'] = this.paymentTokenIds;
    data['phone'] = this.phone;
    // data['picking_warn'] = this.pickingWarn;
    // data['picking_warn_msg'] = this.pickingWarnMsg;
    // data['property_account_payable_id'] = this.propertyAccountPayableId;
    // data['property_account_position_id'] = this.propertyAccountPositionId;
    // data['property_account_receivable_id'] = this.propertyAccountReceivableId;
    // data['property_delivery_carrier_id'] = this.propertyDeliveryCarrierId;
    // data['property_payment_term_id'] = this.propertyPaymentTermId;
    // data['property_product_pricelist'] = this.propertyProductPricelist;
    // data['property_stock_customer'] = this.propertyStockCustomer;
    // data['property_stock_supplier'] = this.propertyStockSupplier;
    // data['property_supplier_payment_term_id'] =
    //     this.propertySupplierPaymentTermId;
    // data['ref'] = this.ref;
    // data['ref_company_ids'] = this.refCompanyIds;
    // data['sale_order_count'] = this.saleOrderCount;
    // data['sale_order_ids'] = this.saleOrderIds;
    // data['sale_warn'] = this.saleWarn;
    // data['sale_warn_msg'] = this.saleWarnMsg;
    // data['self'] = this.self;
    // data['signup_expiration'] = this.signupExpiration;
    // data['signup_token'] = this.signupToken;
    // data['signup_type'] = this.signupType;
    // data['signup_url'] = this.signupUrl;
    // data['signup_valid'] = this.signupValid;
    // data['state_id'] = this.stateId;
    // data['street'] = this.street;
    // data['street2'] = this.street2;
    // data['supplier'] = this.supplier;
    // data['team_id'] = this.teamId;
    if (!(this.title is bool)) if (this.title != null)
      data['title'] = this.title;
    if (this.xClass != null) data['x_class'] = this.xClass;
    if (this.xSchool != null) data['x_school'] = this.xSchool;
    if (!(this.wkDob is bool)) if (this.wkDob != null)
      data['wk_dob'] = this.wkDob;
    // data['total_invoiced'] = this.totalInvoiced;
    // data['trust'] = this.trust;
    // data['type'] = this.type;
    // data['tz'] = this.tz;
    // data['tz_offset'] = this.tzOffset;
    // data['user_id'] = this.userId;
    // data['user_ids'] = this.userIds;
    // data['vat'] = this.vat;
    // data['vehicle_count'] = this.vehicleCount;
    // data['vehicle_ids'] = this.vehicleIds;
    // data['website'] = this.website;
    // data['website_description'] = this.websiteDescription;
    // data['website_id'] = this.websiteId;
    // data['website_message_ids'] = this.websiteMessageIds;
    // data['website_meta_description'] = this.websiteMetaDescription;
    // data['website_meta_keywords'] = this.websiteMetaKeywords;
    // data['website_meta_og_img'] = this.websiteMetaOgImg;
    // data['website_meta_title'] = this.websiteMetaTitle;
    // data['website_published'] = this.websitePublished;
    // data['website_short_description'] = this.websiteShortDescription;
    // data['website_url'] = this.websiteUrl;
    // data['wishlist_ids'] = this.wishlistIds;
    // data['write_date'] = this.writeDate;
    // data['write_uid'] = this.writeUid;
    // data['zip'] = this.zip;
    return data;
  }
}
