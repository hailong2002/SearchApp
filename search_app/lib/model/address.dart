class Address{

  String label;
  String district;
  String subdistrict;
  String street;
  String city;

  Address({
    required this.label,
    required this.district,
    required this.subdistrict,
    required this.street,
    required this.city
  });


  static Address getAddress(Map<String, dynamic> map)
  {
    return Address(
      label: map['label'] ?? '',
      district:  map['district'] ?? '',
      subdistrict: map['subdistrict'] ?? '',
      street: map['street'] ?? '',
      city:  map['city'] ?? ''
    );
  }
}