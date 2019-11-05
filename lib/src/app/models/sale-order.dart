class SaleOrder {
  dynamic sLastUpdate;
  dynamic accessToken;
  dynamic accessUrl;
  dynamic accessWarning;
  dynamic activityDateDeadline;
  dynamic activityIds;
  dynamic activityState;
  dynamic activitySummary;
  dynamic activityTypeId;
  dynamic activityUserId;
  dynamic amountByGroup;
  dynamic amountDelivery;
  dynamic amountTax;
  dynamic amountTotal;
  dynamic amountUndiscounted;
  dynamic amountUntaxed;
  dynamic analyticAccountId;
  dynamic authorizedTransactionIds;
  dynamic availableCarrierIds;
  dynamic campaignId;
  dynamic carrierId;
  dynamic cartQuantity;
  dynamic cartRecoveryEmailSent;
  dynamic clientOrderRef;
  dynamic commitmentDate;
  dynamic companyId;
  dynamic confirmationDate;
  dynamic createDate;
  dynamic createUid;
  dynamic currencyId;
  dynamic currencyRate;
  dynamic dateOrder;
  dynamic deliveryCount;
  dynamic deliveryMessage;
  dynamic deliveryPrice;
  dynamic deliveryRatingSuccess;
  dynamic displayName;
  dynamic effectiveDate;
  dynamic expectedDate;
  dynamic fiscalPositionId;
  dynamic hasDelivery;
  dynamic id;
  dynamic incoterm;
  dynamic invoiceCount;
  dynamic invoiceIds;
  dynamic invoiceShippingOnDelivery;
  dynamic invoiceStatus;
  dynamic isAbandonedCart;
  dynamic isExpired;
  dynamic mediumId;
  dynamic messageAttachmentCount;
  dynamic messageChannelIds;
  dynamic messageFollowerIds;
  dynamic messageHasError;
  dynamic messageHasErrorCounter;
  dynamic messageIds;
  dynamic messageIsFollower;
  dynamic messageMainAttachmentId;
  dynamic messageNeedaction;
  dynamic messageNeedactionCounter;
  dynamic messagePartnerIds;
  dynamic messageUnread;
  dynamic messageUnreadCounter;
  dynamic name;
  dynamic note;
  dynamic onlyServices;
  dynamic opportunityId;
  dynamic orderLine;
  dynamic origin;
  dynamic partnerId;
  dynamic partnerInvoiceId;
  dynamic partnerShippingId;
  dynamic paymentTermId;
  dynamic pickingIds;
  dynamic pickingPolicy;
  dynamic pricelistId;
  dynamic procurementGroupId;
  dynamic reference;
  dynamic remainingValidityDays;
  dynamic requirePayment;
  dynamic requireSignature;
  dynamic saleOrderOptionIds;
  dynamic saleOrderTemplateId;
  dynamic signature;
  dynamic signedBy;
  dynamic sourceId;
  dynamic state;
  dynamic tagIds;
  dynamic teamId;
  dynamic transactionIds;
  dynamic transporterId;
  dynamic typeName;
  dynamic userId;
  dynamic validityDate;
  dynamic warehouseId;
  dynamic warningStock;
  dynamic websiteId;
  dynamic websiteMessageIds;
  dynamic websiteOrderLine;
  dynamic writeDate;
  dynamic writeUid;
  dynamic xIsSameCustomerAddress;
  dynamic xPickupAddress;
  dynamic xSchool;
  dynamic xStartDate;
  dynamic xTime;
  dynamic xVehicles;

  SaleOrder(
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
      this.amountByGroup,
      this.amountDelivery,
      this.amountTax,
      this.amountTotal,
      this.amountUndiscounted,
      this.amountUntaxed,
      this.analyticAccountId,
      this.authorizedTransactionIds,
      this.availableCarrierIds,
      this.campaignId,
      this.carrierId,
      this.cartQuantity,
      this.cartRecoveryEmailSent,
      this.clientOrderRef,
      this.commitmentDate,
      this.companyId,
      this.confirmationDate,
      this.createDate,
      this.createUid,
      this.currencyId,
      this.currencyRate,
      this.dateOrder,
      this.deliveryCount,
      this.deliveryMessage,
      this.deliveryPrice,
      this.deliveryRatingSuccess,
      this.displayName,
      this.effectiveDate,
      this.expectedDate,
      this.fiscalPositionId,
      this.hasDelivery,
      this.id,
      this.incoterm,
      this.invoiceCount,
      this.invoiceIds,
      this.invoiceShippingOnDelivery,
      this.invoiceStatus,
      this.isAbandonedCart,
      this.isExpired,
      this.mediumId,
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
      this.note,
      this.onlyServices,
      this.opportunityId,
      this.orderLine,
      this.origin,
      this.partnerId,
      this.partnerInvoiceId,
      this.partnerShippingId,
      this.paymentTermId,
      this.pickingIds,
      this.pickingPolicy,
      this.pricelistId,
      this.procurementGroupId,
      this.reference,
      this.remainingValidityDays,
      this.requirePayment,
      this.requireSignature,
      this.saleOrderOptionIds,
      this.saleOrderTemplateId,
      this.signature,
      this.signedBy,
      this.sourceId,
      this.state,
      this.tagIds,
      this.teamId,
      this.transactionIds,
      this.transporterId,
      this.typeName,
      this.userId,
      this.validityDate,
      this.warehouseId,
      this.warningStock,
      this.websiteId,
      this.websiteMessageIds,
      this.websiteOrderLine,
      this.writeDate,
      this.writeUid,
      this.xIsSameCustomerAddress,
      this.xPickupAddress,
      this.xSchool,
      this.xStartDate,
      this.xTime,
      this.xVehicles});

  SaleOrder.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    accessToken = json['access_token'];
    accessUrl = json['access_url'];
    accessWarning = json['access_warning'];
    activityDateDeadline = json['activity_date_deadline'];
    activityIds = json['activity_ids'];
    activityState = json['activity_state'];
    activitySummary = json['activity_summary'];
    activityTypeId = json['activity_type_id'];
    activityUserId = json['activity_user_id'];
    amountByGroup = json['amount_by_group'];
    amountDelivery = json['amount_delivery'];
    amountTax = json['amount_tax'];
    amountTotal = json['amount_total'];
    amountUndiscounted = json['amount_undiscounted'];
    amountUntaxed = json['amount_untaxed'];
    analyticAccountId = json['analytic_account_id'];
    authorizedTransactionIds = json['authorized_transaction_ids'];
    availableCarrierIds = json['available_carrier_ids'];
    campaignId = json['campaign_id'];
    carrierId = json['carrier_id'];
    cartQuantity = json['cart_quantity'];
    cartRecoveryEmailSent = json['cart_recovery_email_sent'];
    clientOrderRef = json['client_order_ref'];
    commitmentDate = json['commitment_date'];
    companyId = json['company_id'];
    confirmationDate = json['confirmation_date'];
    createDate = json['create_date'];
    createUid = json['create_uid'];
    currencyId = json['currency_id'];
    currencyRate = json['currency_rate'];
    dateOrder = json['date_order'];
    deliveryCount = json['delivery_count'];
    deliveryMessage = json['delivery_message'];
    deliveryPrice = json['delivery_price'];
    deliveryRatingSuccess = json['delivery_rating_success'];
    displayName = json['display_name'];
    effectiveDate = json['effective_date'];
    expectedDate = json['expected_date'];
    fiscalPositionId = json['fiscal_position_id'];
    hasDelivery = json['has_delivery'];
    id = json['id'];
    incoterm = json['incoterm'];
    invoiceCount = json['invoice_count'];
    invoiceIds = json['invoice_ids'];
    invoiceShippingOnDelivery = json['invoice_shipping_on_delivery'];
    invoiceStatus = json['invoice_status'];
    isAbandonedCart = json['is_abandoned_cart'];
    isExpired = json['is_expired'];
    mediumId = json['medium_id'];
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
    name = json['name'];
    note = json['note'];
    onlyServices = json['only_services'];
    opportunityId = json['opportunity_id'];
    orderLine = json['order_line'];
    origin = json['origin'];
    partnerId = json['partner_id'];
    partnerInvoiceId = json['partner_invoice_id'];
    partnerShippingId = json['partner_shipping_id'];
    paymentTermId = json['payment_term_id'];
    pickingIds = json['picking_ids'];
    pickingPolicy = json['picking_policy'];
    pricelistId = json['pricelist_id'];
    procurementGroupId = json['procurement_group_id'];
    reference = json['reference'];
    remainingValidityDays = json['remaining_validity_days'];
    requirePayment = json['require_payment'];
    requireSignature = json['require_signature'];
    saleOrderOptionIds = json['sale_order_option_ids'];
    saleOrderTemplateId = json['sale_order_template_id'];
    signature = json['signature'];
    signedBy = json['signed_by'];
    sourceId = json['source_id'];
    state = json['state'];
    tagIds = json['tag_ids'];
    teamId = json['team_id'];
    transactionIds = json['transaction_ids'];
    transporterId = json['transporter_id'];
    typeName = json['type_name'];
    userId = json['user_id'];
    validityDate = json['validity_date'];
    warehouseId = json['warehouse_id'];
    warningStock = json['warning_stock'];
    websiteId = json['website_id'];
    websiteMessageIds = json['website_message_ids'];
    websiteOrderLine = json['website_order_line'];
    writeDate = json['write_date'];
    writeUid = json['write_uid'];
    xIsSameCustomerAddress = json['x_is_same_customer_address'];
    xPickupAddress = json['x_pickup_address'];
    xSchool = json['x_school'];
    xStartDate = json['x_start_date'];
    xTime = json['x_time'];
    xVehicles = json['x_vehicles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__last_update'] = this.sLastUpdate;
    data['access_token'] = this.accessToken;
    data['access_url'] = this.accessUrl;
    data['access_warning'] = this.accessWarning;
    data['activity_date_deadline'] = this.activityDateDeadline;
    data['activity_ids'] = this.activityIds;
    data['activity_state'] = this.activityState;
    data['activity_summary'] = this.activitySummary;
    data['activity_type_id'] = this.activityTypeId;
    data['activity_user_id'] = this.activityUserId;
    data['amount_by_group'] = this.amountByGroup;
    data['amount_delivery'] = this.amountDelivery;
    data['amount_tax'] = this.amountTax;
    data['amount_total'] = this.amountTotal;
    data['amount_undiscounted'] = this.amountUndiscounted;
    data['amount_untaxed'] = this.amountUntaxed;
    data['analytic_account_id'] = this.analyticAccountId;
    data['authorized_transaction_ids'] = this.authorizedTransactionIds;
    data['available_carrier_ids'] = this.availableCarrierIds;
    data['campaign_id'] = this.campaignId;
    data['carrier_id'] = this.carrierId;
    data['cart_quantity'] = this.cartQuantity;
    data['cart_recovery_email_sent'] = this.cartRecoveryEmailSent;
    data['client_order_ref'] = this.clientOrderRef;
    data['commitment_date'] = this.commitmentDate;
    data['company_id'] = this.companyId;
    data['confirmation_date'] = this.confirmationDate;
    data['create_date'] = this.createDate;
    data['create_uid'] = this.createUid;
    data['currency_id'] = this.currencyId;
    data['currency_rate'] = this.currencyRate;
    data['date_order'] = this.dateOrder;
    data['delivery_count'] = this.deliveryCount;
    data['delivery_message'] = this.deliveryMessage;
    data['delivery_price'] = this.deliveryPrice;
    data['delivery_rating_success'] = this.deliveryRatingSuccess;
    data['display_name'] = this.displayName;
    data['effective_date'] = this.effectiveDate;
    data['expected_date'] = this.expectedDate;
    data['fiscal_position_id'] = this.fiscalPositionId;
    data['has_delivery'] = this.hasDelivery;
    data['id'] = this.id;
    data['incoterm'] = this.incoterm;
    data['invoice_count'] = this.invoiceCount;
    data['invoice_ids'] = this.invoiceIds;
    data['invoice_shipping_on_delivery'] = this.invoiceShippingOnDelivery;
    data['invoice_status'] = this.invoiceStatus;
    data['is_abandoned_cart'] = this.isAbandonedCart;
    data['is_expired'] = this.isExpired;
    data['medium_id'] = this.mediumId;
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
    data['name'] = this.name;
    data['note'] = this.note;
    data['only_services'] = this.onlyServices;
    data['opportunity_id'] = this.opportunityId;
    data['order_line'] = this.orderLine;
    data['origin'] = this.origin;
    data['partner_id'] = this.partnerId;
    data['partner_invoice_id'] = this.partnerInvoiceId;
    data['partner_shipping_id'] = this.partnerShippingId;
    data['payment_term_id'] = this.paymentTermId;
    data['picking_ids'] = this.pickingIds;
    data['picking_policy'] = this.pickingPolicy;
    data['pricelist_id'] = this.pricelistId;
    data['procurement_group_id'] = this.procurementGroupId;
    data['reference'] = this.reference;
    data['remaining_validity_days'] = this.remainingValidityDays;
    data['require_payment'] = this.requirePayment;
    data['require_signature'] = this.requireSignature;
    data['sale_order_option_ids'] = this.saleOrderOptionIds;
    data['sale_order_template_id'] = this.saleOrderTemplateId;
    data['signature'] = this.signature;
    data['signed_by'] = this.signedBy;
    data['source_id'] = this.sourceId;
    data['state'] = this.state;
    data['tag_ids'] = this.tagIds;
    data['team_id'] = this.teamId;
    data['transaction_ids'] = this.transactionIds;
    data['transporter_id'] = this.transporterId;
    data['type_name'] = this.typeName;
    data['user_id'] = this.userId;
    data['validity_date'] = this.validityDate;
    data['warehouse_id'] = this.warehouseId;
    data['warning_stock'] = this.warningStock;
    data['website_id'] = this.websiteId;
    data['website_message_ids'] = this.websiteMessageIds;
    data['website_order_line'] = this.websiteOrderLine;
    data['write_date'] = this.writeDate;
    data['write_uid'] = this.writeUid;
    data['x_is_same_customer_address'] = this.xIsSameCustomerAddress;
    data['x_pickup_address'] = this.xPickupAddress;
    data['x_school'] = this.xSchool;
    data['x_start_date'] = this.xStartDate;
    data['x_time'] = this.xTime;
    data['x_vehicles'] = this.xVehicles;
    return data;
  }
}
