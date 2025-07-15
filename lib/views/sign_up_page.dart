import 'package:currency_hub/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
    final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Login Page'),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: SignForm(emailController: emailController, passWordController: passWordController, nameController: nameController,)
      ),
    );
  }
}