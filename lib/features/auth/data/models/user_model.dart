import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.email,
    required this.fcmToken,
    required this.name,
    required this.password,
    required this.profileImage,
  });

  final String id;
  final String email;
  final String fcmToken;
  final String name;
  final String password;
  final String profileImage;

  factory UserModel.empty() {
    return const UserModel(
      id: '',
      email: '',
      fcmToken: '',
      name: '',
      password: '',
      profileImage: '',
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? fcmToken,
    String? name,
    String? password,
    String? profileImage,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fcmToken: fcmToken ?? this.fcmToken,
      name: name ?? this.name,
      password: password ?? this.password,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  static UserModel fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, fcmToken: $fcmToken, name: $name, password: $password, profileImage: $profileImage)';
  }

  @override
  List<Object?> get props => [
        id,
        email,
        fcmToken,
        name,
        password,
        profileImage,
      ];
}
