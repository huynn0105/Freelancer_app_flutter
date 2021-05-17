class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final int role;

  const RegisterRequest({
    this.name,
    this.email,
    this.password,
    this.role,
  });
}
