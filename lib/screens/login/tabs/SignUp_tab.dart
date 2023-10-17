import 'package:flutter/material.dart';
import 'package:to_do_app/shared/styles/colors.dart';

class SignUpTab extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var ageController = TextEditingController();

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
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Name';
                }

                return null;
              },
            ),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Age'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Age';
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
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
                if (_formKey.currentState!.validate()) {}
              },
              child: const Text(
                'Sign Up',
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
