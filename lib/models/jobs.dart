class Job {
  int? id;
  String? jobTitle;
  String? description;
  String? location;
  Contact? contact;
  int? userId;
  String? createdAt;

  Job(
      {this.id,
        this.jobTitle,
        this.description,
        this.location,
        this.contact,
        this.userId,
        this.createdAt});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobTitle = json['job_title'];
    description = json['description'];
    location = json['location'];
    contact =
    json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    userId = json['user_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_title'] = this.jobTitle;
    data['description'] = this.description;
    data['location'] = this.location;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
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