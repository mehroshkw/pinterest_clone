const String _BASE_URL = 'http://shehryarkn-001-site3.btempurl.com/api/';

abstract class IBaseResponse {
  final bool status;
  final String message;

  IBaseResponse(this.status, this.message);

  @override
  String toString() {
    return 'IBaseResponse{status: $status, message: $message}';
  }
}

class StatusMessageResponse extends IBaseResponse {
  StatusMessageResponse({required bool status, required String message})
      : super(status, message);

  factory StatusMessageResponse.fromJson(Map<String, dynamic> json) {
    final bool status = json.containsKey('status') ? json['status'] : false;
    final String message = json.containsKey('message') ? json['message'] : '';
    return StatusMessageResponse(status: status, message: message);
  }

  @override
  String toString() {
    return 'StatusMessageResponse: {status: $status, message: $message}';
  }
}

class LoginAuthenticationResponse extends StatusMessageResponse {
  final LoginResponse? user;

  LoginAuthenticationResponse(this.user, bool status, String message)
      : super(status: status, message: message);

  factory LoginAuthenticationResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    final statusMessageResponse = StatusMessageResponse.fromJson(json);
    final userJson =
        json.containsKey('data') ? json['data'] as Map<String, dynamic>? : null;
    return userJson == null
        ? LoginAuthenticationResponse(
            null, statusMessageResponse.status, statusMessageResponse.message)
        : LoginAuthenticationResponse(LoginResponse.fromJson(userJson),
            statusMessageResponse.status, statusMessageResponse.message);
  }
}

class AddFundResponse extends StatusMessageResponse {
  final CustomerIncome? income;

  AddFundResponse(this.income, bool status, String message)
      : super(status: status, message: message);

  factory AddFundResponse.fromJson(Map<String, dynamic> json) {
    final statusMessageResponse = StatusMessageResponse.fromJson(json);
    final fundJson =
        json.containsKey('data') ? json['data'] as Map<String, dynamic>? : null;
    return fundJson == null
        ? AddFundResponse(
            null, statusMessageResponse.status, statusMessageResponse.message)
        : AddFundResponse(CustomerIncome.fromJson(fundJson),
            statusMessageResponse.status, statusMessageResponse.message);
  }
}

class AddShipmentResponse extends StatusMessageResponse {
  final Shipment? shipment;

  AddShipmentResponse(this.shipment, bool status, String message)
      : super(status: status, message: message);

  factory AddShipmentResponse.fromJson(Map<String, dynamic> json) {
    final statusMessageResponse = StatusMessageResponse.fromJson(json);
    final shipmentJson =
        json.containsKey('data') ? json['data'] as Map<String, dynamic>? : null;
    return shipmentJson == null
        ? AddShipmentResponse(
            null, statusMessageResponse.status, statusMessageResponse.message)
        : AddShipmentResponse(Shipment.fromJson(shipmentJson),
            statusMessageResponse.status, statusMessageResponse.message);
  }
}

class AddBusinessCodeResponse extends StatusMessageResponse {
  final BusinessCode? business;

  AddBusinessCodeResponse(this.business, bool status, String message)
      : super(status: status, message: message);
  factory AddBusinessCodeResponse.fromJson(Map<String, dynamic> json) {
    final statusMessageResponse = StatusMessageResponse.fromJson(json);
    final businessJson =
        json.containsKey('data') ? json['data'] as Map<String, dynamic>? : null;
    return businessJson == null
        ? AddBusinessCodeResponse(
            null, statusMessageResponse.status, statusMessageResponse.message)
        : AddBusinessCodeResponse(BusinessCode.fromJson(businessJson),
            statusMessageResponse.status, statusMessageResponse.message);
  }
}

class CustomerIncome {
  final int id;
  final double amount;
  final String currency;
  final String createdDate;
  final double balance;
  final bool isIncome;

  CustomerIncome(
      {required this.id,
      required this.amount,
      required this.currency,
      required this.createdDate,
      required this.balance,
      required this.isIncome});

  factory CustomerIncome.fromJson(Map<String, dynamic> json) {
    final int id = json.containsKey('id') ? json['id'] : 0;
    final int type =
        json.containsKey('transactionType') ? json['transactionType'] : 0;
    final double amount = json.containsKey('amount') ? json['amount'] ?? 0 : 0;
    final double balance =
        json.containsKey('balance') ? json['balance'] ?? 0 : 0;
    final String currency =
        json.containsKey('currency') ? json['currency'] ?? '' : '';
    final String createdDate =
        json.containsKey('createdDate') ? json['createdDate'] : '';

    return CustomerIncome(
      id: id,
      amount: amount,
      balance: balance,
      currency: currency,
      isIncome: type == 1,
      createdDate: createdDate,
    );
  }

  CustomerIncome copyWith({double? amount}) => CustomerIncome(
        id: id,
        amount: amount ?? this.amount,
        currency: currency,
        balance: balance,
        isIncome: isIncome,
        createdDate: createdDate,
      );
}

class ShipmentStatus {
  final int id;
  final String title;

  ShipmentStatus({required this.id, required this.title});

  factory ShipmentStatus.fromJson(Map<String, dynamic> json) {
    final int id = json.containsKey('id') ? json['id'] : 0;
    final String title = json.containsKey('title') ? json['title'] : '';
    return ShipmentStatus(id: id, title: title);
  }
}

class BusinessCode {
  final int id;
  final String businessName;
  final String businessCode;

  BusinessCode(
      {required this.id,
      required this.businessName,
      required this.businessCode});

  factory BusinessCode.fromJson(Map<String, dynamic> json) {
    final int id = json.containsKey('id') ? json['id'] : 0;
    final String businessName =
        json.containsKey('businessName') ? json['businessName'] : '';
    final String businessCode =
        json.containsKey('businessCode') ? json['businessCode'] : '';
    return BusinessCode(
        id: id, businessCode: businessCode, businessName: businessName);
  }
}

class Shipment {
  final int id;
  final double amount;
  final List<String> imagePath;
  final String createdDate;
  final String source;
  final String orderNo;
  final String destination;
  final int shipmentStatusId;

  Shipment(
      {required this.id,
      required this.amount,
      required this.imagePath,
      required this.createdDate,
      required this.source,
      required this.orderNo,
      required this.destination,
      required this.shipmentStatusId});

  factory Shipment.fromJson(Map<String, dynamic> json) {
    final int id = json.containsKey('id') ? json['id'] : 0;
    final String orderNo =
        json.containsKey('orderNo') ? json['orderNo'] ?? '' : 0;
    final double amount = json.containsKey('amount') ? json['amount'] : 0;

    final List<String> imagePath = json.containsKey('shipmentImages')
        ? json['shipmentImages'] == null
            ? <String>[]
            : (json['shipmentImages'] as List<dynamic>)
                .map((e) => e as Map<String, dynamic>)
                .map((e) {
                final imagePath = e['imagePath'] as String;
                return imagePath;
              }).toList()
        : <String>[];

    final String createdDate =
        json.containsKey('createdDate') ? json['createdDate'] : '';
    final String source = json.containsKey('source') ? json['source'] : '';
    final int shipmentStatusId =
        json.containsKey('shipmentStatusId') ? json['shipmentStatusId'] : 0;
    final String destination =
        json.containsKey('destination') ? json['destination'] : '';

    return Shipment(
        id: id,
        amount: amount,
        imagePath: imagePath,
        orderNo: orderNo,
        createdDate: createdDate,
        destination: destination,
        shipmentStatusId: shipmentStatusId,
        source: source);
  }

  Shipment copyWith({int? updatedVotes}) => Shipment(
      id: id,
      amount: amount,
      imagePath: imagePath,
      orderNo: orderNo,
      createdDate: createdDate,
      source: source,
      shipmentStatusId: shipmentStatusId,
      destination: destination);
}

class LoginResponse {
  final String fullName;
  final String email;
  final bool isMale;
  final String dateOfBirth;
  final String country;
  final String phoneNumber;
  final String image;
  final double currentBalance;
  final String city;
  final String businessName;
  final String financeCode;
  final String countryCode;
  final int id;

  LoginResponse(
      {required this.fullName,
      required this.email,
      required this.isMale,
      required this.businessName,
      required this.dateOfBirth,
      required this.country,
      required this.currentBalance,
      required this.financeCode,
      required this.image,
      required this.city,
      required this.countryCode,
      required this.phoneNumber,
      required this.id});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final String fullName =
        json.containsKey('fullName') ? json['fullName'] ?? '' : '';
    final String email = json.containsKey('email') ? json['email'] ?? '' : '';
    final String gender = json.containsKey('gender') ? json['gender'] : 'Male';
    final String dateOfBirth = json.containsKey('dob') ? json['dob'] ?? '' : '';
    final String country =
        json.containsKey('country') ? json['country'] ?? '' : '';
    final double currentBalance =
        json.containsKey('currentBalance') ? json['currentBalance'] ?? 0 : 0;
    final String financeCode =
        json.containsKey('businessCode') ? json['businessCode'] ?? '' : '';
    final String countryCode =
        json.containsKey('countryCode') ? json['countryCode'] ?? '' : '';
    final String businessName =
        json.containsKey('businessName') ? json['businessName'] ?? '' : '';
    final String phoneNumber =
        json.containsKey('phoneNumber') ? json['phoneNumber'] ?? '' : '';
    final String image =
        json.containsKey('imagePath') ? json['imagePath'] ?? '' : '';
    final String city = json.containsKey('city') ? json['city'] ?? '' : '';
    final int id = json.containsKey('id') ? json['id'] : -1;

    return LoginResponse(
        fullName: fullName,
        email: email,
        image: image,
        currentBalance: currentBalance,
        city: city,
        businessName: businessName,
        financeCode: financeCode,
        countryCode: countryCode,
        isMale: gender == 'Male',
        dateOfBirth: dateOfBirth,
        country: country,
        phoneNumber: phoneNumber,
        id: id);
  }

  LoginResponse copyWith(
          {String? fullName,
          String? email,
          String? businessName,
          String? phoneNumber,
          String? image,
          String? countryCode,
          double? currentBalance}) =>
      LoginResponse(
          fullName: fullName ?? this.fullName,
          email: email ?? this.email,
          city: city,
          countryCode: countryCode ?? this.countryCode,
          currentBalance: currentBalance ?? this.currentBalance,
          businessName: businessName ?? this.businessName,
          image: image ?? this.image,
          financeCode: financeCode,
          isMale: isMale,
          dateOfBirth: dateOfBirth,
          country: country,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          id: id);

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        'financeCode': financeCode,
        'countryCode': countryCode,
        'gender': isMale ? 'Male' : 'Female',
        'dob': dateOfBirth,
        'currentBalance': currentBalance,
        'country': country,
        'businessName': businessName,
        'phoneNumber': phoneNumber,
        'imagePath': image,
        'city': city,
        'id': id
      };
}

class News {
  final int id;
  final String title;
  final String formattedDate;
  final String? caption;
  final String? detail;
  final String image;

  News(
      {required this.id,
      required this.title,
      required this.formattedDate,
      required this.image,
      this.caption,
      this.detail});

  factory News.fromJson(Map<String, dynamic> json) {
    final int id = json.containsKey('id') ? json['id'] : 0;
    final String title = json.containsKey('title') ? json['title'] : '';
    final String formattedDate =
        json.containsKey('dateStr') ? json['dateStr'] : '';
    final String? caption = json['caption'];
    final String? detail = json['detail'];
    final String? imagePath = json['imagePath'];
    final String image = imagePath != null ? _BASE_URL + imagePath : '';
    return News(
        id: id,
        title: title,
        formattedDate: formattedDate,
        image: image,
        caption: caption,
        detail: detail);
  }

  @override
  String toString() {
    return 'News{id: $id, title: $title, formattedDate: $formattedDate, caption: $caption, detail: $detail, image: $image}';
  }
}

class Contestant {
  final int id;
  final String name;
  final String? nickname;
  final List<String> images;
  final String? address;
  final int status;
  final bool isActive;
  final int? age;
  final int totalVotes;

  Contestant(
      {required this.id,
      required this.name,
      required this.nickname,
      required this.images,
      required this.address,
      required this.age,
      required this.status,
      required this.totalVotes,
      required this.isActive});

  factory Contestant.fromJson(Map<String, dynamic> json) {
    final int id = json.containsKey('id') ? json['id'] : 0;
    final String name = json.containsKey('name') ? json['name'] : '';
    final String? nickname =
        json.containsKey('nickname') ? json['nickname'] : '';
    final List<String> images = json.containsKey('imagesUrl')
        ? (json['imagesUrl'] as List<dynamic>).map((e) {
            final imagePath = e as String;
            return _BASE_URL + imagePath;
          }).toList()
        : <String>[];
    final String? address = json.containsKey('address') ? json['address'] : '';
    final int? age = json.containsKey('age') ? json['age'] : null;
    final int status = json.containsKey('status') ? json['status'] : 0;
    final bool isActive =
        json.containsKey('isActive') ? (json['isActive'] == 1) : false;
    final int totalVotes =
        json.containsKey('totalVotes') ? json['totalVotes'] : 0;

    return Contestant(
        id: id,
        name: name,
        nickname: nickname,
        images: images,
        age: age,
        address: address,
        totalVotes: totalVotes,
        status: status,
        isActive: isActive);
  }

  Contestant copyWith({int? updatedVotes}) => Contestant(
      id: id,
      name: name,
      nickname: nickname,
      age: age,
      images: images,
      address: address,
      status: status,
      totalVotes: updatedVotes ?? totalVotes,
      isActive: isActive);

  @override
  String toString() {
    return 'Contestant{id: $id, name: $name, nickname: $nickname, images: $images, address: $address, status: $status, isActive: $isActive, age: $age, totalVotes: $totalVotes}';
  }
}

class VoteNowResponse {
  final int status;
  final String message;
  final int boosterBalance;

  const VoteNowResponse(
      {required this.status,
      required this.message,
      required this.boosterBalance});

  factory VoteNowResponse.fromJson(Map<String, dynamic> json) {
    final int status = json.containsKey('status') ? json['status'] : -1;
    final String message = json.containsKey('message') ? json['message'] : '';
    final int boosterBalance =
        json.containsKey('boosterBalance') ? json['boosterBalance'] : 250;

    return VoteNowResponse(
        status: status, message: message, boosterBalance: boosterBalance);
  }

  @override
  String toString() {
    return 'VoteNowResponse{status: $status, message: $message, boosterBalance: $boosterBalance}';
  }
}

class VoteModel {
  final String image, age, country, name;

  const VoteModel(
      {required this.image,
      required this.age,
      required this.country,
      required this.name});
}

class HomeResponse {
  final List<News> news;
  final List<Contestant> contestants;
  final int boosterBalance;
  final String updateRequired;
  final String currentVersion;
  final String? androidUrl;
  final String? appleUrl;

  const HomeResponse(
      {required this.news,
      required this.contestants,
      required this.boosterBalance,
      required this.updateRequired,
      required this.currentVersion,
      required this.androidUrl,
      required this.appleUrl});

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    final List<News> news = json.containsKey('news')
        ? ((json['news'] as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .map((e) => News.fromJson(e))
            .toList())
        : <News>[];
    final List<Contestant> contestants = json.containsKey('contestants')
        ? ((json['contestants'] as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .map((e) => Contestant.fromJson(e))
            .toList())
        : <Contestant>[];
    int boosterBalance =
        json.containsKey('boosterBalance') ? json['boosterBalance'] : 0;
    String updateRequired =
        json.containsKey('updateRequired') ? json['updateRequired'] : '0';
    String currentVersion =
        json.containsKey('currentVersion') ? json['currentVersion'] : '1.0';
    String? androidUrl =
        json.containsKey('androidUrl') ? json['androidUrl'] : null;
    String? appleUrl = json.containsKey('appleUrl') ? json['appleUrl'] : null;

    return HomeResponse(
        news: news,
        contestants: contestants,
        boosterBalance: boosterBalance,
        updateRequired: updateRequired,
        currentVersion: currentVersion,
        androidUrl: androidUrl,
        appleUrl: appleUrl);
  }

  @override
  String toString() {
    return 'HomeResponse{news: $news, contestants: $contestants, boosterBalance: $boosterBalance, updateRequired: $updateRequired, currentVersion: $currentVersion, androidUrl: $androidUrl, appleUrl: $appleUrl}';
  }
}
