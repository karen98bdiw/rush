class PickResponse {
  String pickId;
  String type;

  PickResponse({
    this.pickId,
    this.type,
  });

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();
    data["pickId"] = this.pickId;
    data["type"] = this.type;
    return data;
  }

  factory PickResponse.fromJson(json) {
    return PickResponse(
      pickId: json["pickId"],
      type: json["type"],
    );
  }
}
