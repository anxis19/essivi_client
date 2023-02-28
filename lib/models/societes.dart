class Societes {
  String? societeUID;
  String? societeName;
  String? societeAvatarUrl;
  String? societeEmail;

  Societes({
    this.societeUID,
    this.societeName,
    this.societeAvatarUrl,
    this.societeEmail,
  });

  Societes.fromJson(Map<String, dynamic> json) {
    societeUID = json["societeUID"];
    societeName = json["societeName"];
    societeAvatarUrl = json["societeAvatarUrl"];
    societeEmail = json["societeEmail"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["societeUID"] = this.societeUID;
    data["societeName"] = this.societeName;
    data["societeAvatarUrl"] = this.societeAvatarUrl;
    data["societeEmail"] = this.societeEmail;
    return data;
  }
}
