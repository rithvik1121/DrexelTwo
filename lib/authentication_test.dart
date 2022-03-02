import "package:drexeltwo/authentication.dart";
import "package:flutter/material.dart";

void main() {
  runApp(const AuthenticationTest());
}

class AuthenticationTest extends StatelessWidget {
  const AuthenticationTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Authentication Test', home: Authenticate());
  }
}
