class BodyNotification {
  dynamic appId;
  dynamic contents;
  dynamic heaing;
  dynamic isIos;
  dynamic isAndroid;
  dynamic isWP;
  dynamic isWPWNS;
  dynamic isAdm;
  dynamic isChrome;
  dynamic isChromeWeb;
  dynamic isSafari;
  dynamic isAnyWeb;
  dynamic includedSegments;
  dynamic excludedSegments;
  dynamic includePlayerIds;
  dynamic includeIosTokens;
  dynamic includeAndroidRegIds;
  dynamic includeWpUris;
  dynamic includeWpWnsUris;
  dynamic includeAmazonRegIds;
  dynamic includeChromeRegIds;
  dynamic includeChromeWebRegIds;
  dynamic appIds;
  dynamic tags;
  dynamic iosBadgeType;
  dynamic iosBadgeCount;
  dynamic iosSound;
  dynamic androidSound;
  dynamic admSound;
  dynamic wpSound;
  dynamic wpWnsSound;
  dynamic data;
  dynamic buttons;
  dynamic collapseId;
  dynamic smallIcon;
  dynamic largeIcon;
  dynamic bigPicture;
  dynamic admSmallIcon;
  dynamic admLargeIcon;
  dynamic admBigPicture;
  dynamic chromeIcon;
  dynamic chromeBigPicture;
  dynamic chromeWebIcon;
  dynamic firefoxIcon;
  dynamic url;
  dynamic sendAfter;
  dynamic delayedOption;
  dynamic deliveryTimeOfDay;
  dynamic androidLedColor;
  dynamic androidAccentColor;
  dynamic androidVisibility;
  dynamic contentAvailable;
  dynamic amazonBackgroundData;
  dynamic templateId;
  dynamic androidGroup;
  dynamic androidGroupMessage;
  dynamic admGroup;
  dynamic admGroupMessage;
  dynamic ttl;
  dynamic priority;
  dynamic iosCategory;
  dynamic filters;

  BodyNotification(
      {this.appId,
      this.contents,
      this.heaing,
      this.isIos,
      this.isAndroid,
      this.isWP,
      this.isWPWNS,
      this.isAdm,
      this.isChrome,
      this.isChromeWeb,
      this.isSafari,
      this.isAnyWeb,
      this.includedSegments,
      this.excludedSegments,
      this.includePlayerIds,
      this.includeIosTokens,
      this.includeAndroidRegIds,
      this.includeWpUris,
      this.includeWpWnsUris,
      this.includeAmazonRegIds,
      this.includeChromeRegIds,
      this.includeChromeWebRegIds,
      this.appIds,
      this.tags,
      this.iosBadgeType,
      this.iosBadgeCount,
      this.iosSound,
      this.androidSound,
      this.admSound,
      this.wpSound,
      this.wpWnsSound,
      this.data,
      this.buttons,
      this.collapseId,
      this.smallIcon,
      this.largeIcon,
      this.bigPicture,
      this.admSmallIcon,
      this.admLargeIcon,
      this.admBigPicture,
      this.chromeIcon,
      this.chromeBigPicture,
      this.chromeWebIcon,
      this.firefoxIcon,
      this.url,
      this.sendAfter,
      this.delayedOption,
      this.deliveryTimeOfDay,
      this.androidLedColor,
      this.androidAccentColor,
      this.androidVisibility,
      this.contentAvailable,
      this.amazonBackgroundData,
      this.templateId,
      this.androidGroup,
      this.androidGroupMessage,
      this.admGroup,
      this.admGroupMessage,
      this.ttl,
      this.priority,
      this.iosCategory,
      this.filters});

  BodyNotification.fromJson(Map<String, dynamic> json) {
    appId = json['app_id'];
    contents = json['contents'];
    heaing = json['heaing'];
    isIos = json['isIos'];
    isAndroid = json['isAndroid'];
    isWP = json['isWP'];
    isWPWNS = json['isWP_WNS'];
    isAdm = json['isAdm'];
    isChrome = json['isChrome'];
    isChromeWeb = json['isChromeWeb'];
    isSafari = json['isSafari'];
    isAnyWeb = json['isAnyWeb'];
    includedSegments = json['included_segments'];
    excludedSegments = json['excluded_segments'];
    includePlayerIds = json['include_player_ids'];
    includeIosTokens = json['include_ios_tokens'];
    includeAndroidRegIds = json['include_android_reg_ids'];
    includeWpUris = json['include_wp_uris'];
    includeWpWnsUris = json['include_wp_wns_uris'];
    includeAmazonRegIds = json['include_amazon_reg_ids'];
    includeChromeRegIds = json['include_chrome_reg_ids'];
    includeChromeWebRegIds = json['include_chrome_web_reg_ids'];
    appIds = json['app_ids'];
    tags = json['tags'];
    iosBadgeType = json['ios_badgeType'];
    iosBadgeCount = json['ios_badgeCount'];
    iosSound = json['ios_sound'];
    androidSound = json['android_sound'];
    admSound = json['adm_sound'];
    wpSound = json['wp_sound'];
    wpWnsSound = json['wp_wns_sound'];
    data = json['data'];
    buttons = json['buttons'];
    collapseId = json['collapse_id'];
    smallIcon = json['small_icon'];
    largeIcon = json['large_icon'];
    bigPicture = json['big_picture'];
    admSmallIcon = json['adm_small_icon'];
    admLargeIcon = json['adm_large_icon'];
    admBigPicture = json['adm_big_picture'];
    chromeIcon = json['chrome_icon'];
    chromeBigPicture = json['chrome_big_picture'];
    chromeWebIcon = json['chrome_web_icon'];
    firefoxIcon = json['firefox_icon'];
    url = json['url'];
    sendAfter = json['send_after'];
    delayedOption = json['delayed_option'];
    deliveryTimeOfDay = json['delivery_time_of_day'];
    androidLedColor = json['android_led_color'];
    androidAccentColor = json['android_accent_color'];
    androidVisibility = json['android_visibility'];
    contentAvailable = json['content_available'];
    amazonBackgroundData = json['amazon_background_data'];
    templateId = json['template_id'];
    androidGroup = json['android_group'];
    androidGroupMessage = json['android_group_message'];
    admGroup = json['adm_group'];
    admGroupMessage = json['adm_group_message'];
    ttl = json['ttl'];
    priority = json['priority'];
    iosCategory = json['ios_category'];
    filters = json['filters'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appId != null) data['app_id'] = this.appId;
    if (this.contents != null) data['contents'] = this.contents;
    if (this.heaing != null) data['heaing'] = this.heaing;
    if (this.isIos != null) data['isIos'] = this.isIos;
    if (this.isAndroid != null) data['isAndroid'] = this.isAndroid;
    if (this.isWP != null) data['isWP'] = this.isWP;
    if (this.isWPWNS != null) data['isWP_WNS'] = this.isWPWNS;
    if (this.isAdm != null) data['isAdm'] = this.isAdm;
    if (this.isChrome != null) data['isChrome'] = this.isChrome;
    if (this.isChromeWeb != null) data['isChromeWeb'] = this.isChromeWeb;
    if (this.isSafari != null) data['isSafari'] = this.isSafari;
    if (this.isAnyWeb != null) data['isAnyWeb'] = this.isAnyWeb;
    if (this.includedSegments != null)
      data['included_segments'] = this.includedSegments;
    if (this.excludedSegments != null)
      data['excluded_segments'] = this.excludedSegments;
    if (this.includePlayerIds != null)
      data['include_player_ids'] = this.includePlayerIds;
    if (this.includeIosTokens != null)
      data['include_ios_tokens'] = this.includeIosTokens;
    if (this.includeAndroidRegIds != null)
      data['include_android_reg_ids'] = this.includeAndroidRegIds;
    if (this.includeWpUris != null)
      data['include_wp_uris'] = this.includeWpUris;
    if (this.includeWpWnsUris != null)
      data['include_wp_wns_uris'] = this.includeWpWnsUris;
    if (this.includeAmazonRegIds != null)
      data['include_amazon_reg_ids'] = this.includeAmazonRegIds;
    if (this.includeChromeRegIds != null)
      data['include_chrome_reg_ids'] = this.includeChromeRegIds;
    if (this.includeChromeWebRegIds != null)
      data['include_chrome_web_reg_ids'] = this.includeChromeWebRegIds;
    if (this.appIds != null) data['app_ids'] = this.appIds;
    if (this.tags != null) data['tags'] = this.tags;
    if (this.iosBadgeType != null) data['ios_badgeType'] = this.iosBadgeType;
    if (this.iosBadgeCount != null) data['ios_badgeCount'] = this.iosBadgeCount;
    if (this.iosSound != null) data['ios_sound'] = this.iosSound;
    if (this.androidSound != null) data['android_sound'] = this.androidSound;
    if (this.admSound != null) data['adm_sound'] = this.admSound;
    if (this.wpSound != null) data['wp_sound'] = this.wpSound;
    if (this.wpWnsSound != null) data['wp_wns_sound'] = this.wpWnsSound;
    if (this.data != null) data['data'] = this.data;
    if (this.buttons != null) data['buttons'] = this.buttons;
    if (this.collapseId != null) data['collapse_id'] = this.collapseId;
    if (this.smallIcon != null) data['small_icon'] = this.smallIcon;
    if (this.largeIcon != null) data['large_icon'] = this.largeIcon;
    if (this.bigPicture != null) data['big_picture'] = this.bigPicture;
    if (this.admSmallIcon != null) data['adm_small_icon'] = this.admSmallIcon;
    if (this.admLargeIcon != null) data['adm_large_icon'] = this.admLargeIcon;
    if (this.admBigPicture != null)
      data['adm_big_picture'] = this.admBigPicture;
    if (this.chromeIcon != null) data['chrome_icon'] = this.chromeIcon;
    if (this.chromeBigPicture != null)
      data['chrome_big_picture'] = this.chromeBigPicture;
    if (this.chromeWebIcon != null)
      data['chrome_web_icon'] = this.chromeWebIcon;
    if (this.firefoxIcon != null) data['firefox_icon'] = this.firefoxIcon;
    if (this.url != null) data['url'] = this.url;
    if (this.sendAfter != null) data['send_after'] = this.sendAfter;
    if (this.delayedOption != null) data['delayed_option'] = this.delayedOption;
    if (this.deliveryTimeOfDay != null)
      data['delivery_time_of_day'] = this.deliveryTimeOfDay;
    if (this.androidLedColor != null)
      data['android_led_color'] = this.androidLedColor;
    if (this.androidAccentColor != null)
      data['android_accent_color'] = this.androidAccentColor;
    if (this.androidVisibility != null)
      data['android_visibility'] = this.androidVisibility;
    if (this.contentAvailable != null)
      data['content_available'] = this.contentAvailable;
    if (this.amazonBackgroundData != null)
      data['amazon_background_data'] = this.amazonBackgroundData;
    if (this.templateId != null) data['template_id'] = this.templateId;
    if (this.androidGroup != null) data['android_group'] = this.androidGroup;
    if (this.androidGroupMessage != null)
      data['android_group_message'] = this.androidGroupMessage;
    if (this.admGroup != null) data['adm_group'] = this.admGroup;
    if (this.admGroupMessage != null)
      data['adm_group_message'] = this.admGroupMessage;
    if (this.ttl != null) data['ttl'] = this.ttl;
    if (this.priority != null) data['priority'] = this.priority;
    if (this.iosCategory != null) data['ios_category'] = this.iosCategory;
    if (this.filters != null) data['filters'] = this.filters;
    return data;
  }
}
