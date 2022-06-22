class SignUpInput {
  SignUpInput({
    this.email,
    this.password,
    // this.verificationCode,
    this.phoneNumber,
    this.confirmPassword,
    this.name,
    this.phone,
  });

  String? email;
  String? password;
  String? confirmPassword;
  String? phoneNumber;
  // String? verificationCode;
  String? name;
  int? phone;

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "name": name,
        // "verificationcode": verificationCode
      };

  factory SignUpInput.fromMap(Map<String, dynamic> json) => SignUpInput(
      email: json["email"],
      password: json["password"],
      phone: json["phoneNumber"],
      name: json["name"]);
}
