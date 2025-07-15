import 'package:currency_hub/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Currency Hub', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.black,
        ),
        body: LoginForm(emailController: emailController, passWordController: passWordController)
      ),
    );
  }
}
