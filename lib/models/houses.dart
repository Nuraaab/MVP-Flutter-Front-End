class House {
  int? id;
  String? title;
  String? description;
  Contact? contact;
  String? location;
  String? photo;
  String? price;
  int? userId;
  String? name;
  String? createdAt;
  String? profile;

  House(
      {this.id,
        this.title,
        this.description,
        this.contact,
        this.location,
        this.photo,
        this.price,
        this.userId,
        this.name,
        this.createdAt,
        this.profile});

  House.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    contact =
    json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    location = json['location'];
    photo = json['photo'];
    price = json['price'];
    userId = json['user_id'];
    name = json['name'];
    createdAt = json['created_at'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    data['location'] = this.location;
    data['photo'] = this.photo;
    data['price'] = this.price;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['profile'] = this.profile;
    return data;
  }
}

class Contact {
  String? phone;
  String? address;

  Contact({this.phone, this.address});

  Contact.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}