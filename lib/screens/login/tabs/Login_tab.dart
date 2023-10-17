import 'package:flutter/material.dart';
import 'package:to_do_app/layout/home_layout.dart';
import 'package:to_do_app/shared/network/firebase/firebase_manager.dart';
import 'package:to_do_app/shared/styles/colors.dart';

class LoginTab extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Email';
                }
                final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);

                if (!emailValid) {
                  return "Please Enter Valid Email";
                }

                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  FirebaseManager.login(
                      emailController.text, passwordController.text, () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeLayout.routeName, (route) => false);
                  }, (error) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        title: Text("Error"),
                        content: Text(error.toString()),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primary),
                              child: Text("Okay"))
                        ],
                      ),
                    );
                  });
                }
              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: primary),
            ),
          ],
        ),
      ),
    );
  }
}
