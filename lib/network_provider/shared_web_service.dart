import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pinterest_clone/network_provider/photos_model.dart';
import 'package:pinterest_clone/network_provider/server_response.dart';

import '../helpers/shared_preference_helper.dart';

class SharedWebService {
  static const _BASE_URL = 'http://shehryarkn-001-site3.btempurl.com/api/';
  // static const LOCAL_BASE_URL = 'http://192.168.1.26:5090/api/';

  final HttpClient _client = HttpClient();
  final Duration _timeoutDuration = const Duration(seconds: 20);
  final SharedPreferenceHelper _sharedPrefHelper = SharedPreferenceHelper();

  // Future<LoginResponse?> get _loginResponse => _sharedPrefHelper.user;

  static SharedWebService? _instance;

  SharedWebService._();

  static SharedWebService instance() {
    _instance ??= SharedWebService._();
    return _instance!;
  }

  Future<HttpClientResponse> _responseFrom(
          Future<HttpClientRequest> Function(Uri) toCall,
          {required Uri uri,
          Map<String, dynamic>? body,
          Map<String, String>? headers}) =>
      toCall(uri).then((request) {
        if (headers != null) {
          headers.forEach((key, value) => request.headers.add(key, value));
        }
        if (request.method == 'POST' && body != null) {
          request.headers.contentType =
              ContentType('application', 'json', charset: 'utf-8');
          request.add(utf8.encode(json.encode(body)));
        }
        return request.close();
      }).timeout(_timeoutDuration);

  Future<HttpClientResponse> _get(Uri uri, [Map<String, String>? headers]) =>
      _responseFrom(_client.getUrl, uri: uri, headers: headers);

  Future<HttpClientResponse> _post(Uri uri,
          [Map<String, dynamic>? body, Map<String, String>? headers]) => _responseFrom(_client.postUrl, uri: uri, body: body, headers: headers);

  Future<LoginAuthenticationResponse> login(
      String email, String password, bool isUser) async {
    final response = await _post(
        Uri.parse('$_BASE_URL${!isUser ? 'Customer' : 'Employee'}/Login'), {'email': email, 'password': password});
    final responseBody = await response.transform(utf8.decoder).join();

    return LoginAuthenticationResponse.fromJson(json.decode(responseBody));
  }
  Future<Photos?> getApi() async{
    final response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=all&per_page=30&page=1"),
        headers: {"Authorization": "563492ad6f917000010000012876927f901846cd8b5d658bbe09bcda"});
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      // print("Successfully called API");
      // print(response.body.toString());
      // for(Map i in data){
      //   newsModel.add(News.fromJson(i));
      // }
      return Photos.fromJson(data);
    }else{
      print("Error occured during api call");
      return Photos.fromJson(data);

    }
  }
}

//   Future<LoginAuthenticationResponse> updateProfile(
//       LoginResponse user, String previousImage) async {
//     final id = (await _loginResponse)?.id;
//     if (id == null) throw const IdNotFoundException();
//     final image = previousImage == user.image
//           ? previousImage : base64Encode((await File(user.image).readAsBytes()));
//
//     final body = previousImage == user.image
//         ? {
//             'id': id,
//             'fullName': user.fullName,
//             'email': user.email,
//             'countryCode': user.countryCode,
//             'businessName': user.businessName,
//             'phoneNumber': user.phoneNumber
//           }
//         : {
//             'id': id,
//             'fullName': user.fullName,
//             'email': user.email,
//             'imagestream': image,
//             'countryCode': user.countryCode,
//             'businessName': user.businessName,
//             'phoneNumber': user.phoneNumber
//           };
//     final uri = Uri.parse('${_BASE_URL}Customer/UpdateCustomer');
//     final response = await _post(uri, body);
//     final responseBody = await response.transform(utf8.decoder).join();
//     print(responseBody);
//     return LoginAuthenticationResponse.fromJson(json.decode(responseBody));
//   }
//
//   Future<LoginAuthenticationResponse> signup(
//       String firstName,
//       String email,
//       String password,
//       String image,
//       String gender,
//       String telephoneNumber,
//       String financeCode,
//       String businessName,
//       String countryCode) async {
//     final headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'multipart/form-data'
//     };
//     final body = {
//       'fullName': firstName,
//       'email': email,
//       'password': password,
//       'gender': gender,
//       'businessName': businessName,
//       'businessCode': financeCode,
//       'phoneNumber': telephoneNumber,
//       'countryCode': countryCode,
//     };
//
//     final uri = Uri.parse('${_BASE_URL}Customer/SignUp');
//     final request = http.MultipartRequest('POST', uri);
//     final imageFile = await http.MultipartFile.fromPath('Image', image);
//     request.headers.addAll(headers);
//     request.files.add(imageFile);
//     request.fields.addAll(body);
//     final response = await request.send();
//     final responseData = await response.stream.bytesToString();
//     return LoginAuthenticationResponse.fromJson(json.decode(responseData));
//   }
//
//   Future<AddShipmentResponse> addShipment(List<String> imagesPath, String phoneNumber) async {
//     final id = (await _loginResponse)?.id;
//     if (id == null) throw const IdNotFoundException();
//     List<String> imagesPathConverter=[];
//     print(imagesPathConverter.toString());
//
//     for (var element in imagesPath)  {
//       imagesPathConverter.add(base64Encode((await File(element).readAsBytes())));
//     }
//     print(imagesPathConverter);
//     print(id);
//
//     final response = await _post(Uri.parse('${_BASE_URL}Shipment/AddShipments'), {
//       'customerId': id,
//       'id': '5',
//       'phoneNumber': phoneNumber,
//       'imagestream': imagesPathConverter
//     });
//     final responseBody = await response.transform(utf8.decoder).join();
//     return AddShipmentResponse.fromJson(json.decode(responseBody));
//   }
//
//   Future<AddBusinessCodeResponse> addBusiness(
//       String businessName, String businessCode) async {
//     final id = (await _loginResponse)?.id;
//     if (id == null) throw const IdNotFoundException();
//     final response = await _post(Uri.parse('${_BASE_URL}Customer/AddBusinessCode'), {'businessCode': businessCode, 'businessName': businessName, 'customerId': id});
//       final responseBody = await response.transform(utf8.decoder).join();
//     return AddBusinessCodeResponse.fromJson(json.decode(responseBody));
//   }
//
//   Future<List<BusinessCode>> getBusiness() async {
//     final token = (await _loginResponse)?.id;
//     if (token == null) throw const IdNotFoundException();
//     final response = await _get(Uri.parse('${_BASE_URL}Customer/GetBusinessCodeByCustomerId?customerId=$token'));
//     print(response.statusCode);
//     final responseBody = await response.transform(utf8.decoder).join();
//     print(responseBody);
//     return compute(parseCustomerBusiness,responseBody);
//   }
//
//   Future<AddFundResponse> addFund(
//       String amount, String currency, int id) async {
//     final response = await _post(
//         Uri.parse('${_BASE_URL}CustomerIncome/AddCustomerIncome'),
//         {'amount': amount, 'currency': currency, 'customerId': id});
//     final responseBody = await response.transform(utf8.decoder).join();
//     print(responseBody);
//     return AddFundResponse.fromJson(json.decode(responseBody));
//   }
//
//   Future<List<LoginResponse>> getAllCustomer() async {
//     final response = await _get(Uri.parse('${_BASE_URL}Customer/GetAllCustomer'));
//     final responseBody = await response.transform(utf8.decoder).join();
//     return compute(parseAllCustomerResponse, responseBody);
//   }
//
//   Future<List<CustomerIncome>> customerIncome() async {
//     final token = (await _loginResponse)?.id;
//     if (token == null) throw const IdNotFoundException();
//     final response = await _get(Uri.parse(
//         '${_BASE_URL}CustomerIncome/GetCustomerIncomeByCustomerId?id=$token'));
//     final responseBody = await response.transform(utf8.decoder).join();
//     return compute(parseCustomerIncome, responseBody);
//   }
//
//   Future<List<CustomerIncome>> employeeSideCustomerIncome(int id) async {
//     final response = await _get(Uri.parse(
//         '${_BASE_URL}CustomerIncome/GetCustomerIncomeByCustomerId?id=$id'));
//     final responseBody = await response.transform(utf8.decoder).join();
//     return compute(parseCustomerIncome, responseBody);
//   }
//
//   Future<MapEntry<List<Shipment>, List<ShipmentStatus>>> getActiveShipment() async {
//     final token = (await _loginResponse)?.id;
//     if (token == null) throw const IdNotFoundException();
//     final response = await _get(
//         Uri.parse('${_BASE_URL}Shipment/GetActiveShipments?Id=$token'));
//     final responseBody = await response.transform(utf8.decoder).join();
//
//     final shipments = await compute(parseHistoryShipment, responseBody);
//     final shipmentsStatus = await compute(parseShipmentStatus, responseBody);
//     return MapEntry(shipments, shipmentsStatus);
//   }
//
//   Future<MapEntry<List<Shipment>, List<ShipmentStatus>>> getEmployeeShipment(
//       int id) async {
//     final response =
//         await _get(Uri.parse('${_BASE_URL}Shipment/GetActiveShipments?Id=$id'));
//     final responseBody = await response.transform(utf8.decoder).join();
//
//     final shipments = await compute(parseHistoryShipment, responseBody);
//     final shipmentsStatus = await compute(parseShipmentStatus, responseBody);
//     return MapEntry(shipments, shipmentsStatus);
//   }
//
//   Future<List<Shipment>> getHistoryShipment() async {
//     final token = (await _loginResponse)?.id;
//     if (token == null) throw const IdNotFoundException();
//     final response = await _get(
//         Uri.parse('${_BASE_URL}Shipment/GetShipmentsHistory?Id=$token'));
//     final responseBody = await response.transform(utf8.decoder).join();
//     return compute(parseHistoryShipment, responseBody);
//   }
//
//   Future<List<CustomerIncome>> customerOutCome() async {
//     final token = (await _loginResponse)?.id;
//     if (token == null) throw const IdNotFoundException();
//     final response = await _get(Uri.parse(
//         '${_BASE_URL}CustomerOutcome/GetCustomerOutcomeByCustomerId?id=$token'));
//     final responseBody = await response.transform(utf8.decoder).join();
//
//     return compute(parseCustomerIncome, responseBody);
//   }
//
//   Future<List<CustomerIncome>> getStatement() async {
//     final token = (await _loginResponse)?.id;
//     if (token == null) throw const IdNotFoundException();
//     final response = await _get(Uri.parse('${_BASE_URL}Customer/GetStatementByCustomerId?customerId=$token'));
//     print(response.statusCode);
//     final responseBody = await response.transform(utf8.decoder).join();
//     print(responseBody);
//     return compute(parseCustomerIncome, responseBody);
//   }
//
//   Future<List<CustomerIncome>> employeeSideCustomerOutCome(int id) async {
//     final response = await _get(Uri.parse(
//         '${_BASE_URL}CustomerOutcome/GetCustomerOutcomeByCustomerId?id=$id'));
//     final responseBody = await response.transform(utf8.decoder).join();
//
//     return compute(parseCustomerIncome, responseBody);
//   }
//
//   Future<List<News>> news() async {
//     final response = await _get(Uri.parse('${_BASE_URL}News/GetAllNews'));
//     final responseBody = await response.transform(utf8.decoder).join();
//     return compute(parseNews, responseBody);
//   }
//
//   Future<MapEntry<VoteNowResponse, LoginResponse>> voteNow(
//       int contestantId, int numberOfVotes) async {
//     final loginResponse = await _loginResponse;
//     if (loginResponse == null) throw const IdNotFoundException();
//     final response = await _post(Uri.parse('${_BASE_URL}Contestant/Vote'), {
//       'appUserId': loginResponse.id,
//       'contestantId': contestantId,
//       'votes': numberOfVotes
//     });
//     final responseBody = await response.transform(utf8.decoder).join();
//     return MapEntry(
//         VoteNowResponse.fromJson(json.decode(responseBody)), loginResponse);
//   }
//
//   Future<IBaseResponse> forgetPassword(String email) async {
//     final response = await _get(Uri.parse('${_BASE_URL}Account/ForgetPassword?email=$email'));
//     final responseBody = await response.transform(utf8.decoder).join();
//     return StatusMessageResponse.fromJson(json.decode(responseBody));
//   }
//
//   Future<IBaseResponse> changePassword(
//       String oldPassword, String newPassword) async {
//     final loginResponse = await _loginResponse;
//     if (loginResponse == null) throw const IdNotFoundException();
//     final response = await _post(Uri.parse('${_BASE_URL}Customer/ChangePassword'), {
//       'customerId': loginResponse.id,
//       'oldPassword': oldPassword,
//       'newPassword': newPassword
//     });
//     final responseBody = await response.transform(utf8.decoder).join();
//     return StatusMessageResponse.fromJson(json.decode(responseBody));
//   }
// }
//
// List<News> parseNews(String responseBody) =>
//     (json.decode(responseBody) as List<dynamic>)
//         .map((e) => e as Map<String, dynamic>)
//         .map((e) => News.fromJson(e))
//         .toList();
//
// List<CustomerIncome> parseCustomerIncome(String responseBody) =>
//     (json.decode(responseBody) as List<dynamic>)
//         .map((e) => e as Map<String, dynamic>)
//         .map((e) => CustomerIncome.fromJson(e))
//         .toList();
// List<BusinessCode> parseCustomerBusiness(String responseBody) =>
//     (json.decode(responseBody) as List<dynamic>)
//         .map((e) => e as Map<String, dynamic>)
//         .map((e) => BusinessCode.fromJson(e))
//         .toList();
//
// List<ShipmentStatus> parseShipmentStatus(String responseBody) =>
//     (json.decode(responseBody)['shipmentStatuses'] as List<dynamic>)
//         .map((e) => e as Map<String, dynamic>)
//         .map((e) => ShipmentStatus.fromJson(e))
//         .toList();
//
// List<Shipment> parseShipment(String responseBody) =>
//     (json.decode(responseBody)[''] as List<dynamic>)
//         .map((e) => e as Map<String, dynamic>)
//         .map((e) => Shipment.fromJson(e))
//         .toList();
//
// List<Shipment> parseHistoryShipment(String responseBody) =>
//     (json.decode(responseBody)['shipments'] as List<dynamic>)
//         .map((e) => e as Map<String, dynamic>)
//         .map((e) => Shipment.fromJson(e))
//         .toList();
//
// List<LoginResponse> parseAllCustomerResponse(String responseBody) =>
//     (json.decode(responseBody) as List<dynamic>)
//         .map((e) => e as Map<String, dynamic>)
//         .map((e) => LoginResponse.fromJson(e))
//         .toList();
