class SaleOrderLine {
  String sLastUpdate;
  List<dynamic> analyticLineIds;
  List<dynamic> analyticTagIds;
  List<dynamic> companyId;
  String createDate;
  List<dynamic> createUid;
  List<dynamic> currencyId;
  dynamic customerLead;
  dynamic discount;
  String displayName;
  dynamic displayType;
  dynamic eventId;
  dynamic eventOk;
  dynamic eventTicketId;
  dynamic id;
  List<dynamic> invoiceLines;
  String invoiceStatus;
  dynamic isDelivery;
  dynamic isDownpayment;
  dynamic isExpense;
  dynamic linkedLineId;
  List<dynamic> moveIds;
  String name;
  String nameShort;
  List<dynamic> optionLineIds;
  List<dynamic> orderId;
  List<dynamic> orderPartnerId;
  dynamic priceReduce;
  dynamic priceReduceTaxexcl;
  dynamic priceReduceTaxinc;
  dynamic priceSubtotal;
  dynamic priceTax;
  dynamic priceTotal;
  dynamic priceUnit;
  List<dynamic> productCustomAttributeValueIds;
  List<dynamic> productId;
  dynamic productImage;
  List<dynamic> productNoVariantAttributeValueIds;
  dynamic productPackaging;
  dynamic productQty;
  List<dynamic> productUom;
  dynamic productUomQty;
  dynamic productUpdatable;
  dynamic qtyDelivered;
  dynamic qtyDeliveredManual;
  String qtyDeliveredMethod;
  dynamic qtyInvoiced;
  dynamic qtyToInvoice;
  dynamic routeId;
  List<dynamic> saleOrderOptionIds;
  List<dynamic> salesmanId;
  dynamic sequence;
  String state;
  List<dynamic> taxId;
  dynamic untaxedAmountInvoiced;
  dynamic untaxedAmountToInvoice;
  dynamic warningStock;
  String writeDate;
  List<dynamic> writeUid;

  SaleOrderLine(
      {this.sLastUpdate,
      this.analyticLineIds,
      this.analyticTagIds,
      this.companyId,
      this.createDate,
      this.createUid,
      this.currencyId,
      this.customerLead,
      this.discount,
      this.displayName,
      this.displayType,
      this.eventId,
      this.eventOk,
      this.eventTicketId,
      this.id,
      this.invoiceLines,
      this.invoiceStatus,
      this.isDelivery,
      this.isDownpayment,
      this.isExpense,
      this.linkedLineId,
      this.moveIds,
      this.name,
      this.nameShort,
      this.optionLineIds,
      this.orderId,
      this.orderPartnerId,
      this.priceReduce,
      this.priceReduceTaxexcl,
      this.priceReduceTaxinc,
      this.priceSubtotal,
      this.priceTax,
      this.priceTotal,
      this.priceUnit,
      this.productCustomAttributeValueIds,
      this.productId,
      this.productImage,
      this.productNoVariantAttributeValueIds,
      this.productPackaging,
      this.productQty,
      this.productUom,
      this.productUomQty,
      this.productUpdatable,
      this.qtyDelivered,
      this.qtyDeliveredManual,
      this.qtyDeliveredMethod,
      this.qtyInvoiced,
      this.qtyToInvoice,
      this.routeId,
      this.saleOrderOptionIds,
      this.salesmanId,
      this.sequence,
      this.state,
      this.taxId,
      this.untaxedAmountInvoiced,
      this.untaxedAmountToInvoice,
      this.warningStock,
      this.writeDate,
      this.writeUid});

  SaleOrderLine.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    if (json["analytic_line_ids"] != null) {
      analyticLineIds = List<dynamic>.from(
          json["analytic_line_ids"] != null ? json["analytic_line_ids"] : []);
    }
    if (json["analytic_tag_ids"] != null) {
      analyticTagIds = List<dynamic>.from(
          json["analytic_tag_ids"] != null ? json["analytic_tag_ids"] : []);
    }
    if (json["company_id"] != null) {
      companyId = List<dynamic>.from(
          json["company_id"] != null ? json["company_id"] : []);
    }
    createDate = json['create_date'];
    if (json["create_uid"] != null) {
      createUid = List<dynamic>.from(
          json["create_uid"] != null ? json["create_uid"] : []);
    }
    if (json["currency_id"] != null) {
      currencyId = List<dynamic>.from(
          json["currency_id"] != null ? json["currency_id"] : []);
    }
    customerLead = json['customer_lead'];
    discount = json['discount'];
    displayName = json['display_name'];
    displayType = json['display_type'];
    eventId = json['event_id'];
    eventOk = json['event_ok'];
    eventTicketId = json['event_ticket_id'];
    id = json['id'];
    if (json["invoice_lines"] != null) {
      invoiceLines = List<dynamic>.from(
          json["invoice_lines"] != null ? json["invoice_lines"] : []);
    }
    invoiceStatus = json['invoice_status'];
    isDelivery = json['is_delivery'];
    isDownpayment = json['is_downpayment'];
    isExpense = json['is_expense'];
    linkedLineId = json['linked_line_id'];
    if (json["move_ids"] != null) {
      moveIds =
          List<dynamic>.from(json["move_ids"] != null ? json["move_ids"] : []);
    }
    name = json['name'];
    nameShort = json['name_short'];
    if (json["option_line_ids"] != null) {
      optionLineIds = List<dynamic>.from(
          json["option_line_ids"] != null ? json["option_line_ids"] : []);
    }
    if (json["order_id"] != null) {
      orderId =
          List<dynamic>.from(json["order_id"] != null ? json["order_id"] : []);
    }
    if (json["order_partner_id"] != null) {
      orderPartnerId = List<dynamic>.from(
          json["order_partner_id"] != null ? json["order_partner_id"] : []);
    }
    priceReduce = json['price_reduce'];
    priceReduceTaxexcl = json['price_reduce_taxexcl'];
    priceReduceTaxinc = json['price_reduce_taxinc'];
    priceSubtotal = json['price_subtotal'];
    priceTax = json['price_tax'];
    priceTotal = json['price_total'];
    priceUnit = json['price_unit'];
    if (json["product_custom_attribute_value_ids"] != null) {
      productCustomAttributeValueIds = List<dynamic>.from(
          json["product_custom_attribute_value_ids"] != null
              ? json["product_custom_attribute_value_ids"]
              : []);
    }
    if (json["product_id"] != null) {
      productId = List<dynamic>.from(
          json["product_id"] != null ? json["product_id"] : []);
    }
    productImage = json['product_image'];
    if (json["product_no_variant_attribute_value_ids"] != null) {
      productNoVariantAttributeValueIds = List<dynamic>.from(
          json["product_no_variant_attribute_value_ids"] != null
              ? json["product_no_variant_attribute_value_ids"]
              : []);
    }
    productPackaging = json['product_packaging'];
    productQty = json['product_qty'];
    if (json["product_uom"] != null) {
      productUom = List<dynamic>.from(
          json["product_uom"] != null ? json["product_uom"] : []);
    }
    productUomQty = json['product_uom_qty'];
    productUpdatable = json['product_updatable'];
    qtyDelivered = json['qty_delivered'];
    qtyDeliveredManual = json['qty_delivered_manual'];
    qtyDeliveredMethod = json['qty_delivered_method'];
    qtyInvoiced = json['qty_invoiced'];
    qtyToInvoice = json['qty_to_invoice'];
    routeId = json['route_id'];
    if (json["sale_order_option_ids"] != null) {
      saleOrderOptionIds = List<dynamic>.from(
          json["sale_order_option_ids"] != null
              ? json["sale_order_option_ids"]
              : []);
    }
    if (json["salesman_id"] != null) {
      salesmanId = List<dynamic>.from(
          json["salesman_id"] != null ? json["salesman_id"] : []);
    }
    sequence = json['sequence'];
    state = json['state'];
    if (json["tax_id"] != null) {
      taxId = List<dynamic>.from(json["tax_id"] != null ? json["tax_id"] : []);
    }
    untaxedAmountInvoiced = json['untaxed_amount_invoiced'];
    untaxedAmountToInvoice = json['untaxed_amount_to_invoice'];
    warningStock = json['warning_stock'];
    writeDate = json['write_date'];
    if (json["write_uid"] != null) {
      writeUid = List<dynamic>.from(
          json["write_uid"] != null ? json["write_uid"] : []);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__last_update'] = this.sLastUpdate;
    data['analytic_line_ids'] = this.analyticLineIds;
    data['analytic_tag_ids'] = this.analyticTagIds;
    data['company_id'] = this.companyId;
    data['create_date'] = this.createDate;
    data['create_uid'] = this.createUid;
    data['currency_id'] = this.currencyId;
    data['customer_lead'] = this.customerLead;
    data['discount'] = this.discount;
    data['display_name'] = this.displayName;
    data['display_type'] = this.displayType;
    data['event_id'] = this.eventId;
    data['event_ok'] = this.eventOk;
    data['event_ticket_id'] = this.eventTicketId;
    data['id'] = this.id;
    data['invoice_lines'] = this.invoiceLines;
    data['invoice_status'] = this.invoiceStatus;
    data['is_delivery'] = this.isDelivery;
    data['is_downpayment'] = this.isDownpayment;
    data['is_expense'] = this.isExpense;
    data['linked_line_id'] = this.linkedLineId;
    data['move_ids'] = this.moveIds;
    data['name'] = this.name;
    data['name_short'] = this.nameShort;
    data['option_line_ids'] = this.optionLineIds;
    data['order_id'] = this.orderId;
    data['order_partner_id'] = this.orderPartnerId;
    data['price_reduce'] = this.priceReduce;
    data['price_reduce_taxexcl'] = this.priceReduceTaxexcl;
    data['price_reduce_taxinc'] = this.priceReduceTaxinc;
    data['price_subtotal'] = this.priceSubtotal;
    data['price_tax'] = this.priceTax;
    data['price_total'] = this.priceTotal;
    data['price_unit'] = this.priceUnit;
    data['product_custom_attribute_value_ids'] =
        this.productCustomAttributeValueIds;
    data['product_id'] = this.productId;
    data['product_image'] = this.productImage;
    data['product_no_variant_attribute_value_ids'] =
        this.productNoVariantAttributeValueIds;
    data['product_packaging'] = this.productPackaging;
    data['product_qty'] = this.productQty;
    data['product_uom'] = this.productUom;
    data['product_uom_qty'] = this.productUomQty;
    data['product_updatable'] = this.productUpdatable;
    data['qty_delivered'] = this.qtyDelivered;
    data['qty_delivered_manual'] = this.qtyDeliveredManual;
    data['qty_delivered_method'] = this.qtyDeliveredMethod;
    data['qty_invoiced'] = this.qtyInvoiced;
    data['qty_to_invoice'] = this.qtyToInvoice;
    data['route_id'] = this.routeId;
    data['sale_order_option_ids'] = this.saleOrderOptionIds;
    data['salesman_id'] = this.salesmanId;
    data['sequence'] = this.sequence;
    data['state'] = this.state;
    data['tax_id'] = this.taxId;
    data['untaxed_amount_invoiced'] = this.untaxedAmountInvoiced;
    data['untaxed_amount_to_invoice'] = this.untaxedAmountToInvoice;
    data['warning_stock'] = this.warningStock;
    data['write_date'] = this.writeDate;
    data['write_uid'] = this.writeUid;
    return data;
  }
}
