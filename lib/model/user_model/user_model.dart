class UserModel {
    UserModel({
        required this.id,
        required this.fullname,
        required this.email,
        required this.password,
        required this.role,
        required this.resetTokenExpire,
        required this.createdAt,
        required this.v,
        required this.accessToken,
        required this.resetToken,
    });

    final String? id;
    final String? fullname;
    final String? email;
    final String? password;
    final String? role;
    final DateTime? resetTokenExpire;
    final DateTime? createdAt;
    final int? v;
    final String? accessToken;
    final String? resetToken;

    factory UserModel.fromJson(Map<String, dynamic> json){ 
        return UserModel(
            id: json["_id"],
            fullname: json["fullname"],
            email: json["email"],
            password: json["password"],
            role: json["role"],
            resetTokenExpire: DateTime.tryParse(json["resetTokenExpire"] ?? ""),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            v: json["__v"],
            accessToken: json["accessToken"],
            resetToken: json["resetToken"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "email": email,
        "password": password,
        "role": role,
        "resetTokenExpire": resetTokenExpire?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "accessToken": accessToken,
        "resetToken": resetToken,
    };

}
