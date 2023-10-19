import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/screens/login/sign_up_screen.dart';
import '../../layout/home_layout.dart';
import '../../providers/my_provider.dart';
import '../../shared/network/firebase/firebase_manager.dart';
import '../../shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {

  static const String routeName = "loginScreen";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var provider = Provider.of<MyProvider>(context);


    return Scaffold(

      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 73,),
            Text("Hi, Welcome Back! ",style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 24,
              color: Theme.of(context).colorScheme.secondary
            )),
            const SizedBox(height: 20,),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: emailController,
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      decoration:  InputDecoration(labelText: 'Email',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primary),),labelStyle:  TextStyle(color: Theme.of(context).colorScheme.onSecondary) ),


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
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: passwordController,
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      obscureText: true,
                      decoration:  InputDecoration(labelText: 'Password',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primary),),labelStyle:  TextStyle(color: Theme.of(context).colorScheme.onSecondary) ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Forgot Password?",style: TextStyle(fontSize: 15,color: primary),)
                      ],),
                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          FirebaseManager.login(
                              emailController.text, passwordController.text, () {
                            provider.initUser();
                            Navigator.pushNamedAndRemoveUntil(
                                context, HomeLayout.routeName, (route) => false);
                          }, (error) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AlertDialog(
                                title: const Text("Error"),
                                content: Text(error.toString()),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: primary),
                                      child: const Text("Okay"))
                                ],
                              ),
                            );
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: primary),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
              Text("Don’t have an account ? ",style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w400
              ),),
              const SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(context, SignUpScreen.routeName, (route) => false);
                },
                child: Text("Sign Up",style: GoogleFonts.poppins(
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
