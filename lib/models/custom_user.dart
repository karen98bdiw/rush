import 'dart:io';
import 'package:http_parser/http_parser.dart' as h;

import 'package:dio/dio.dart';

class CustomUser {
  String id;
  String userName;
  String email;
  String avatar;
  File _uploadedAvatgar;

  CustomUser({
    this.email,
    this.id,
    this.userName,
    this.avatar,
    uploadedAvatgar,
  }) {
    this._uploadedAvatgar = uploadedAvatgar;
  }

  factory CustomUser.fromJson(json) => CustomUser(
        avatar: json["avatar"],
        email: json["email"],
        id: json["id"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();
    data["id"] = this.id;
    data["avatar"] = this.avatar;
    data["username"] = this.userName;
    data["email"] = this.email;
    return data;
  }

  Map<String, dynamic> toRegJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data["avatar"] = _uploadedAvatgar != null
        ? MultipartFile.fromFileSync(
            _uploadedAvatgar.path,
            filename: _uploadedAvatgar.path.split("/").last,
            contentType: h.MediaType(
                "image", _uploadedAvatgar.path.split("/").last.split(".").last),
          )
        : null;
    data["username"] = this.userName;
    data["email"] = this.email;
    return data;
  }

  set setUploadedAvatar(File value) => this._uploadedAvatgar = value;
}
