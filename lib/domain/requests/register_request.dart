class RegisterRequest {
  final String name;
  final String email;
  final String phone;
  final String password;
  final int role;

  const RegisterRequest({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.role,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['role'] = this.role;
    data['password'] = this.password;
    return data;
  }
}
