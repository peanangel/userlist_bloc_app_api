// // lib/models/user.dart
// import 'package:equatable/equatable.dart';

// class User extends Equatable {
//   final int id;
//   final String name;
//   final String email;

//   const User({
//     required this.id,
//     required this.name,
//     required this.email,
//   });

//   // Factory constructor สำหรับสร้าง User object จาก JSON (Map)
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       email: json['email'] as String,
//     );
//   }

//   @override
//   List<Object?> get props => [id, name, email];
// }

import 'package:equatable/equatable.dart';

// Address model for nested address data
class Address extends Equatable {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  const Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  // Factory constructor to create Address from JSON
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String,
      suite: json['suite'] as String,
      city: json['city'] as String,
      zipcode: json['zipcode'] as String,
      geo: Geo.fromJson(json['geo'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [street, suite, city, zipcode, geo];
}

// Geo model for latitude and longitude
class Geo extends Equatable {
  final String lat;
  final String lng;

  const Geo({
    required this.lat,
    required this.lng,
  });

  // Factory constructor to create Geo from JSON
  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      lat: json['lat'] as String,
      lng: json['lng'] as String,
    );
  }

  @override
  List<Object?> get props => [lat, lng];
}

// Company model for nested company data
class Company extends Equatable {
  final String name;
  final String catchPhrase;
  final String bs;

  const Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  // Factory constructor to create Company from JSON
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'] as String,
      catchPhrase: json['catchPhrase'] as String,
      bs: json['bs'] as String,
    );
  }

  @override
  List<Object?> get props => [name, catchPhrase, bs];
}

// User model including Address and Company
class User extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  // Factory constructor to create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      phone: json['phone'] as String,
      website: json['website'] as String,
      company: Company.fromJson(json['company'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [id, name, username, email, address, phone, website, company];
}
