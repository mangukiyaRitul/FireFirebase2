import 'package:fire_flutter/Pages/singin_sreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Services/auth.dart';
import '../componet/textformfild.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  TextEditingController email = TextEditingController();
  TextEditingController pas = TextEditingController();
  TextEditingController confirmpas = TextEditingController();

  final  formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset("asset/animation/animation_lm089fmz.json"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: MyTextFormFieldFireFlutter(
                  controller: email,
                  validator: (emailvalue) {
                    if(emailvalue!.isEmpty) return "Please Enter email";
                    else
                    {
                      return null;
                    }
                  },
                  lable: "Email",
                  hintText: "Enter your email",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: MyTextFormFieldFireFlutter(
                  controller: pas,
                  validator: (emailvalue) {
                    if(emailvalue!.isEmpty) return "Please Enter email";
                    else
                    {
                      return null;
                    }

                  },
                  lable: "Enter Password",
                  hintText: "Enter password",
                ),
              ),
              SizedBox(height: 20,),
              ActionChip(
                label: Text("SingUp"),
                onPressed: () {
                  if(formkey.currentState!.validate())
                  {
                    AuthProvider().signInWithEmailAndPassword(
                      email: email.text.trim(),
                      password: pas.text,
                    );
                  }
                },
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                Text("Don't have an Account? ",style: TextStyle(
                  color: Colors.grey
                )),
                InkWell(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => Singuppage(),));
                    },
                    child: Text("SignUp")),
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
