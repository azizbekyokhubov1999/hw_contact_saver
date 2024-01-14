class Contact {
  late String phoneNumber;
  late String name;

  Contact({
    required this.phoneNumber,
    required this.name,
  });

  Contact.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
    'phoneNumber' : phoneNumber,
    'name' : name,
  };
}