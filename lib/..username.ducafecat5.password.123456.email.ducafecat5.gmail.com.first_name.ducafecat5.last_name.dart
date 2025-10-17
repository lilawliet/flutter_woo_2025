import 'package:collection/collection.dart';

class  {
	String? username;
	String? password;
	String? email;
	String? firstName;
	String? lastName;

	({
		this.username, 
		this.password, 
		this.email, 
		this.firstName, 
		this.lastName, 
	});

	factory .fromJson(Map<String, dynamic> json) => (
				username: json['username'] as String?,
				password: json['password'] as String?,
				email: json['email'] as String?,
				firstName: json['first_name'] as String?,
				lastName: json['last_name'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'username': username,
				'password': password,
				'email': email,
				'first_name': firstName,
				'last_name': lastName,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! ) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			username.hashCode ^
			password.hashCode ^
			email.hashCode ^
			firstName.hashCode ^
			lastName.hashCode;
}
