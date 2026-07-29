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

	factory UserModel.fromMap(String uid, Map<String, dynamic> data) {
		return UserModel(
			uid: uid,
			email: (data['email'] ?? '') as String,
			firstName: (data['firstName'] ?? '') as String,
			lastName: (data['lastName'] ?? '') as String,
			aboutMe: (data['aboutMe'] ?? '') as String,
			photoUrl: (data['photoUrl'] ?? '') as String,
			isProfileDone: (data['isProfileDone'] ?? false) as bool,
		);
	}

	Map<String, dynamic> toMap() {
		return {
			'uid': uid,
			'email': email,
			'firstName': firstName,
			'lastName': lastName,
			'aboutMe': aboutMe,
			'photoUrl': photoUrl,
			'isProfileDone': isProfileDone,
			'updatedAt': DateTime.now().toIso8601String(),
		};
	}
}
