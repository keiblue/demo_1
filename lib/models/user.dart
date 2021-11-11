class User {
  final int id;
  final String name;
  final String username;
  final String email;

  const User(this.id, this.name, this.username, this.email);

  @override
  String toString() {
    return "Nombre: " +
        name +
        "\nUserName: " +
        username +
        "\nEmail: " +
        email +
        "\nId: " +
        id.toString();
  }
}
