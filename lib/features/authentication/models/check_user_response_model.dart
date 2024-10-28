class CheckUserResponse {
  bool? success;
  Data? data;

  CheckUserResponse({this.success, this.data});

  CheckUserResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  bool? userFound;

  Data({this.userFound});

  Data.fromJson(Map<String, dynamic> json) {
    userFound = json['userFound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userFound'] = userFound;
    return data;
  }
}
