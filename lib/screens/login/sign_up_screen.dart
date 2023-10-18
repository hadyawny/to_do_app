import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/screens/login/login_screen.dart';
import 'package:to_do_app/shared/styles/theming.dart';

import '../../layout/home_layout.dart';
import '../../providers/my_provider.dart';
import '../../shared/network/firebase/firebase_manager.dart';
import '../../shared/styles/colors.dart';

class SignUpScreen extends StatelessWidget {

  static const String routeName = "signUpScreen";

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var ageController = TextEditingController();
    var provider = Provider.of<MyProvider>(context);


    return Scaffold(

      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 73,),
            Text("Create an account ",style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 24
            )),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primary),),labelStyle: TextStyle(color: Colors.grey) ),
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
                      decoration: InputDecoration(labelText: 'Age',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primary),),labelStyle: TextStyle(color: Colors.grey) ),
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
                      decoration: InputDecoration(labelText: 'Email',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primary),),labelStyle: TextStyle(color: Colors.grey) ),
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
                      decoration: InputDecoration(labelText: 'Password',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primary),),labelStyle: TextStyle(color: Colors.grey) ),
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
                          FirebaseManager.createAccount(
                              nameController.text,
                              int.parse(ageController.text),
                              emailController.text,
                              passwordController.text, () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, LoginScreen.routeName, (route) => false);
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
                        'Sign Up',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: primary),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text("Have an account ? ",style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400
                ),),
                SizedBox(width: 10,),
                InkWell(
                  onTap: (){
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
                  },
                  child: Text("Log In",style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: primary,
                      fontWeight: FontWeight.w600
                  ),),
                ),
              ],)
          ],
        ),
      ),
    );
  }
}
