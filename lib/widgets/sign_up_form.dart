import 'package:currency_hub/service/firebase_signUp_service.dart';
import 'package:flutter/material.dart';

class SignForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passWordController;
  const SignForm({super.key, required this.nameController, required this.emailController, required this.passWordController});

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                   Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [const Text('Name')],
                ),
                SizedBox(height: 10),
                TextField(
                  controller: widget.nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [const Text('Email')],
                ),
                SizedBox(height: 10),
                TextField(
                  controller: widget.emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [const Text('Password')],
                ),
                SizedBox(height: 10),
                TextField(
                  controller: widget.passWordController,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(onPressed: () async {
                  final response = await FirebaseSignupService().signUpFireBaseApi(
                      widget.emailController.text,
                      widget.passWordController.text,
                    );
                    if (response != null) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error signing up'),
                        ),
                      );
                    }
                  }, child: const Text('SignUp'))),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Sign In')),
                    ],
                  ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.facebook),
                    SizedBox(width: 15),
                    Icon(Icons.email),
                    SizedBox(width: 15),
                    Icon(Icons.facebook),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}