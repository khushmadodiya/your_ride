

import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:your_ride/globle/globle.dart';
import 'package:your_ride/screens/login%20scrren.dart';
import 'package:your_ride/screens/main%20screen.dart';
import 'package:your_ride/screens/resister%20screen.dart';

class ForgetPassword extends StatefulWidget{
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailTextEditingController = TextEditingController();

  final _formkey =GlobalKey<FormState>();
  void _submit()async{
    if(_formkey.currentState!.validate()) {
      await firebaseAuth.sendPasswordResetEmail(email: emailTextEditingController.text.trim()).then((auth) async {
        await Fluttertoast.showToast(msg: "go to email and reset your password");
        Navigator.push(
            context, MaterialPageRoute(builder: (Context) => logIn()));
      }).catchError((errorMessage) {
        Fluttertoast.showToast(msg: "Error occured: \n $errorMessage");
        print(errorMessage);
      });
    }
    else{
      Fluttertoast.showToast(msg: "Not all fields are valid");
    }

  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Text("Forgot Password",
                style: TextStyle(
                  color: darkTheme ? Colors.amber.shade300 : Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,30,40,50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key:_formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50)
                          ],
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 20
                            ),
                            filled: true,
                            fillColor: darkTheme ? Colors.black26 : Colors.black12,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none
                                )
                            ),
                            prefixIcon: Icon(Icons.person,color: darkTheme ? Colors.amber.shade400: Colors.grey,),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text){
                            if(text==null || text.isEmpty){
                              return 'Email can\'t be empty';
                            }
                            if(text.length<2){
                              return 'Please Enter a valid Email';
                            }
                            if(EmailValidator.validate(text)==true){
                              return null;
                            }
                            if(text.length>49){
                              return 'Email can\'t be greater than 50';
                            }

                          },
                          onChanged: (text)=>setState(() {
                            emailTextEditingController.text =text;
                          }),
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: darkTheme ? Colors.amber.shade400 : Colors.blue,
                              onPrimary: darkTheme ? Colors.black : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),

                              ),
                              minimumSize: Size(double.infinity, 50)

                          ),
                          onPressed: (){
                            _submit();
                          }, child: Text("Reset password"),
                        ),



                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

}