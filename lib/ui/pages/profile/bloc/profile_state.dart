part of 'profile_bloc.dart';

class ProfileState {
  final String name;
  final String phoneNumber;
  final DateTime registerDate;
  final bool? activeNameField;
  final bool? activePhoneField;
  TextEditingController nameController;
  TextEditingController phoneController;
  final String? tempName;
  final String? tempPhoto;

  ProfileState({
    required this.name,
    required this.phoneNumber,
    required this.registerDate,
    this.activeNameField = false,
    this.activePhoneField = false,
    required this.nameController,
    required this.phoneController,
    required this.tempName,
    required this.tempPhoto,
  });

  ProfileState copyWith({
    final String? name,
    final String? phoneNumber,
    final DateTime? registerDate,
    bool? activeFieldName,
    bool? activePhoneName,
    String? tempName,
    String? tempPhoto,
    TextEditingController? nameController,
    TextEditingController? phoneController,
  }) {
    return ProfileState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      registerDate: registerDate ?? this.registerDate,
      activeNameField: activeFieldName ?? false,
      activePhoneField: activePhoneName ?? false,
      nameController: nameController ?? this.nameController,
      phoneController: phoneController ?? this.phoneController,
      tempName: tempName ?? this.tempName,
      tempPhoto: tempPhoto ?? this.tempPhoto,
    );
  }
}

class ProfileInitial extends ProfileState {
  ProfileInitial({
    required super.name,
    required super.phoneNumber,
    required super.registerDate,
    super.activeNameField,
    super.activePhoneField,
    required super.nameController,
    required super.phoneController,
    super.tempName,
    super.tempPhoto,
  });
}
