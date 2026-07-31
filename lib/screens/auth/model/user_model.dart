class UserModel {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String aboutMe;
  final String photoUrl;
  final bool isProfileDone;

  const UserModel({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.aboutMe,
    required this.photoUrl,
    required this.isProfileDone,
  });

  String get fullName => [firstName, lastName]
      .where((part) => part.trim().isNotEmpty)
      .join(' ');

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      email: map['email'] as String? ?? '',
      firstName: map['firstName'] as String? ?? '',
      lastName: map['lastName'] as String? ?? '',
      aboutMe: map['aboutMe'] as String? ?? '',
      photoUrl: map['photoUrl'] as String? ?? '',
      isProfileDone: map['isProfileDone'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'aboutMe': aboutMe,
      'photoUrl': photoUrl,
      'isProfileDone': isProfileDone,
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? aboutMe,
    String? photoUrl,
    bool? isProfileDone,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      aboutMe: aboutMe ?? this.aboutMe,
      photoUrl: photoUrl ?? this.photoUrl,
      isProfileDone: isProfileDone ?? this.isProfileDone,
    );
  }
}