

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class register extends StatefulWidget{
  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  Color dark = Colors.black45;
  Color light = Colors.black12;

  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final conformPasswordTextEditingController = TextEditingController();
  bool _passwordvisibal =false;

  final _formkey =GlobalKey<FormState>();
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
                child: Text("Register",
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50)
                            ],
                            decoration: InputDecoration(
                              hintText: "Name",
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
                                return 'Name can\'t be empty';
                              }
                              if(text.length<2){
                                return 'Please Enter a valid Name';
                              }
                              if(text.length>49){
                                return 'Name can\'t be greater than 50';
                              }
                            },
                            onChanged: (text)=>setState(() {
                              nameTextEditingController.text =text;
                            }),
                          ),
                          SizedBox(height: 15,),
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
                          SizedBox(height: 15,),
                          IntlPhoneField(
                            showCountryFlag: true,
                            dropdownIcon: Icon(Icons.arrow_drop_down,color: darkTheme ? Colors.amber.shade400: Colors.grey,),
                            decoration: InputDecoration(
                              hintText: "Phone",
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
                            initialCountryCode: 'IN',
                            onChanged: (text)=>setState(() {
                              phoneTextEditingController.text =text.completeNumber;
                            }),
                          ),
                          SizedBox(height: 8,),
                          TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50)
                            ],
                            decoration: InputDecoration(
                              hintText: "Address",
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
                                return 'Address can\'t be empty';
                              }
                              if(text.length<2){
                                return 'Please Enter a valid address';
                              }
                              if(text.length>49){
                                return 'Address can\'t be greater than 50';
                              }
                            },
                            onChanged: (text)=>setState(() {
                              addressTextEditingController.text =text;
                            }),
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            obscureText: !_passwordvisibal,

                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50)
                            ],
                            decoration: InputDecoration(
                              hintText: "Password",
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordvisibal ? Icons.visibility : Icons.visibility_off,
                                  color: darkTheme ? Colors.amber.shade400 : Colors.grey,
                                ), onPressed: () {
                                  setState(() {
                                    _passwordvisibal =!_passwordvisibal;
                                  });
                              },
                              ),
                              prefixIcon: Icon(Icons.password,color: darkTheme ? Colors.amber.shade400: Colors.grey,),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (text){
                              if(text==null || text.isEmpty){
                                return 'Password can\'t be empty';
                              }
                              if(text.length<2){
                                return 'Please Enter a valid password';
                              }
                              if(text.length>49){
                                return 'Password can\'t be greater than 50';
                              }
                              return null;
                            },
                            onChanged: (text)=>setState(() {
                              passwordTextEditingController.text =text;
                            }),
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            obscureText: !_passwordvisibal,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50)
                            ],
                            decoration: InputDecoration(
                              hintText: "Conform Password",
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordvisibal ? Icons.visibility : Icons.visibility_off,
                                  color: darkTheme ? Colors.amber.shade400 : Colors.grey,
                                ), onPressed: () {
                                setState(() {
                                  _passwordvisibal =!_passwordvisibal;
                                });
                              },
                              ),
                              prefixIcon: Icon(Icons.password,color: darkTheme ? Colors.amber.shade400: Colors.grey,),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (text){
                              if(text==null || text.isEmpty){
                                return 'Conform Password can\'t be empty';
                              }
                              if(text != passwordTextEditingController.text){
                                return 'password do not match ';
                              }
                              if(text.length<2){
                                return 'Please Enter a valid conform password';
                              }
                              if(text.length>49){
                                return 'Conform Password can\'t be greater than 50';
                              }
                              return null;
                            },
                            onChanged: (text)=>setState(() {
                              passwordTextEditingController.text =text;
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

                          }, child: Text("Register"))

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