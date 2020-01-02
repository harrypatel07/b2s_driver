library appsetting;

import 'package:b2s_driver/src/app/provider/api.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

final LocalStorage localStorage = new LocalStorage("localStorage");

String domainApi = "http://www.bus2school.vn";

const String client_id = 'XUanvRsb5NvRscvMfc6wNtgiHOF8F0';
const String client_secret = 'c665Xgd3mt3SLbPVLdVjRawJg4kzd5';

const String password_client_id = 'jwLXOqcQ14QD68jUrVlnfQiYXgAPyn';
const String password_client_secret = 'a2EEtXnVfjf1QPRy7CAzkdPpbiYP0m';

const String admin_id = "bus2school";
const String admin_password = "B@S#2019";

final String ggKey = "AIzaSyCjB1Kh7OstaDns8ie6uPysWEWa_vwS3iw";

const String oneSignal_myAppId = "ece1d724-31f9-4372-9ecf-5b13ad2baef0";

const String oneSignal_appId = "ece1d724-31f9-4372-9ecf-5b13ad2baef0";

const String oneSignal_restKey =
    "MTNkMDBjOWMtZjM3Ni00YzlkLWJmMWEtOThhMTAwOWQwMjYz";

const superKeyEncrypt = "b2s@#encrypt";

const emptyState = {
  'assetImage': AssetImage('assets/images/empty.png'),
  'assetPath': 'assets/images/empty.png',
};

Api api = new Api();
