class RegisterRequest {
  final String name;
  final String email;
  final String phone;
  final String password;

  const RegisterRequest({
    this.name,
    this.email,
    this.password,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
