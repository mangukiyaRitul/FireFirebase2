import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Services/auth.dart';
import '../componet/textformfild.dart';

class Singuppage extends StatefulWidget {
  const Singuppage({super.key});

  @override
  State<Singuppage> createState() => _SinguppageState();
}

class _SinguppageState extends State<Singuppage> {

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 300,
                child: Lottie.asset("asset/animation/animation_lm08cxc5.json"),),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: MyTextFormFieldFireFlutter(
                    controller: confirmpas,
                    validator: (emailvalue) {
                      if(emailvalue!.isEmpty) return "Please Enter email";
                      else
                      {
                        if(pas.text == confirmpas.text)
                          {
                            return null;
                          }
                        else{
                          return "Not Match password";
                        }
                      }
                    },
                    lable: "Confirm Password",
                    hintText: "Enter password",
                  ),
                ),
                SizedBox(height: 20,),
                ActionChip(
                  label: Text("SingUp"),
                  onPressed: () {
                   if(formkey.currentState!.validate())
                     {
                       AuthProvider().registerWithEmailAndPassword(
                         email: email.text.trim(),
                         password: pas.text,
                       );
                     }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
