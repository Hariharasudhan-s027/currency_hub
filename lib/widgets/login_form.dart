import 'package:currency_hub/service/firebase_googleLogin_service.dart';
import 'package:currency_hub/service/firebase_login_service.dart';
import 'package:currency_hub/views/home_page.dart';
import 'package:currency_hub/views/sign_up_page.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passWordController;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passWordController,
  });

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLoading = false; // Example: dynamic state
  bool _obscureText = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: widget.emailController,
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 16),
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Password',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 5),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: widget.passWordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  errorStyle: TextStyle(
                    fontSize: 16.0,
                    height: 1.5,
                    overflow: TextOverflow.visible,
                  ),
                  errorMaxLines: 3,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  final passwordRegex = RegExp(
                    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
                  );
                  if (!passwordRegex.hasMatch(value)) {
                    return 'Password must be at least 8 characters long,\ninclude uppercase, lowercase, number, and special character.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 18),
              SizedBox(
                width: MediaQuery.of(context).size.width - 35,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    backgroundColor: Colors.black,
                  ),

                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final response = await FirebaseLoginService()
                          .loginFireBaseApi(
                            widget.emailController.text,
                            widget.passWordController.text,
                          );
                      if (response != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid email or password'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.facebook),
                    iconSize: 35,
                    onPressed: () {},
                  ),
                  SizedBox(width: 15),
                  IconButton(
                    icon: Icon(Icons.email),
                    iconSize: 35,
                    onPressed: () async {
                      final response =
                          await FirebaseGoogleloginService()
                              .firebaseGoogleLogin();

                      if (response != null) {
                        // Success: navigate to next screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ), // replace with your screen
                        );
                      } else {
                        print('❌ Google sign-in failed');
                      }
                    },
                  ),

                  SizedBox(width: 15),
                  IconButton(
                    iconSize: 35,
                    icon: Icon(Icons.one_x_mobiledata),
                    onPressed: () {
                           FirebaseGoogleloginService().signOutFirebase();

                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
