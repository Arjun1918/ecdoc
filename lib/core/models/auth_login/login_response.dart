// class LoginResponse {
//   final String? token;
//   final String? refreshToken;
//   final String? message;
//
//   LoginResponse({
//     this.token,
//     this.refreshToken,
//     this.message,
//   });
//
//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     return LoginResponse(
//       token: json["data"]?["accessToken"],
//       refreshToken: json["data"]?["refreshToken"],
//       message: json["message"],
//     );
//   }
// }

class LoginResponse {
  final Doctors? doctors;

  LoginResponse({this.doctors});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      doctors:
      json['doctors'] != null ? Doctors.fromJson(json['doctors']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (doctors != null) 'doctors': doctors!.toJson(),
    };
  }
}

class Doctors {
  final Login? login;
  final int? success;

  Doctors({this.login, this.success});

  factory Doctors.fromJson(Map<String, dynamic> json) {
    return Doctors(
      login: json['login'] != null ? Login.fromJson(json['login']) : null,
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (login != null) 'login': login!.toJson(),
      'success': success,
    };
  }
}

class Login {
  final Info? info;
  final bool? authStatus;
  final Doctor? doctor;

  Login({this.info, this.authStatus, this.doctor});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      info: json['info'] != null ? Info.fromJson(json['info']) : null,
      authStatus: json['auth_status'],
      doctor: json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (info != null) 'info': info!.toJson(),
      'auth_status': authStatus,
      if (doctor != null) 'doctor': doctor!.toJson(),
    };
  }
}

class Info {
  final AccountInfo? accountInfo;
  final String? recordId;
  final String? token;
  final String? accountId;

  Info({this.accountInfo, this.recordId, this.token, this.accountId});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      accountInfo: json['account_info'] != null
          ? AccountInfo.fromJson(json['account_info'])
          : null,
      recordId: json['record_id'],
      token: json['token'],
      accountId: json['account_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (accountInfo != null) 'account_info': accountInfo!.toJson(),
      'record_id': recordId,
      'token': token,
      'account_id': accountId,
    };
  }
}

class AccountInfo {
  final Account? account;

  AccountInfo({this.account});

  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    return AccountInfo(
      account:
      json['Account'] != null ? Account.fromJson(json['Account']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (account != null) 'Account': account!.toJson(),
    };
  }
}

class Account {
  final String? lastStateChange;
  final int? failedLoginCount;
  final String? lastLoginAt;
  final int? totalLoginCount;
  final String? contactEmail;
  final String? state;
  final int? accountType;
  final String? fullName;
  final String? id;
  final List<AuthSystem>? authSystem;

  Account({
    this.lastStateChange,
    this.failedLoginCount,
    this.lastLoginAt,
    this.totalLoginCount,
    this.contactEmail,
    this.state,
    this.accountType,
    this.fullName,
    this.id,
    this.authSystem,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      lastStateChange: json['lastStateChange'],
      failedLoginCount: json['failedLoginCount'],
      lastLoginAt: json['lastLoginAt'],
      totalLoginCount: json['totalLoginCount'],
      contactEmail: json['contactEmail'],
      state: json['state'],
      accountType: json['accountType'],
      fullName: json['fullName'],
      id: json['id'],
      authSystem: (json['authSystem'] as List<dynamic>?)
          ?.map((e) => AuthSystem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastStateChange': lastStateChange,
      'failedLoginCount': failedLoginCount,
      'lastLoginAt': lastLoginAt,
      'totalLoginCount': totalLoginCount,
      'contactEmail': contactEmail,
      'state': state,
      'accountType': accountType,
      'fullName': fullName,
      'id': id,
      if (authSystem != null)
        'authSystem': authSystem!.map((e) => e.toJson()).toList(),
    };
  }
}

class AuthSystem {
  final String? username;
  final String? name;

  AuthSystem({this.username, this.name});

  factory AuthSystem.fromJson(Map<String, dynamic> json) {
    return AuthSystem(
      username: json['username'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
    };
  }
}

class Doctor {
  final String? coverArt;
  final String? displayName;
  final String? name;
  final String? degree;
  final String? mobile;
  final String? demail;
  final String? specialityType;
  final String? hospitalName;
  final String? doctorEmail;
  final String? role;
  final String? avatar;
  final String? contactNo2;
  final String? doctorId;
  final String? fullname;
  final String? speciality;

  Doctor({
    this.coverArt,
    this.displayName,
    this.name,
    this.degree,
    this.mobile,
    this.demail,
    this.specialityType,
    this.hospitalName,
    this.doctorEmail,
    this.role,
    this.avatar,
    this.contactNo2,
    this.doctorId,
    this.fullname,
    this.speciality,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      coverArt: json['cover_art'],
      displayName: json['display_name'],
      name: json['name'],
      degree: json['degree'],
      mobile: json['mobile'],
      demail: json['demail'],
      specialityType: json['speciality_type'],
      hospitalName: json['hospital_name'],
      doctorEmail: json['doctor_email'],
      role: json['role'],
      avatar: json['avatar'],
      contactNo2: json['contact_no2'],
      doctorId: json['doctor_id'],
      fullname: json['fullname'],
      speciality: json['speciality'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cover_art': coverArt,
      'display_name': displayName,
      'name': name,
      'degree': degree,
      'mobile': mobile,
      'demail': demail,
      'speciality_type': specialityType,
      'hospital_name': hospitalName,
      'doctor_email': doctorEmail,
      'role': role,
      'avatar': avatar,
      'contact_no2': contactNo2,
      'doctor_id': doctorId,
      'fullname': fullname,
      'speciality': speciality,
    };
  }
}
