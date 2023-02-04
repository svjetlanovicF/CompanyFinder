import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import '../components/rounded_textfield.dart';
import '../services/firebase_service.dart';
import 'package:get_it/get_it.dart';
import './home_screen.dart';
import '../models/user.dart' as u;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FirebaseService? _firebaseService;
  u.User user = u.User();

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: Colors.greenAccent.shade400,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "SIGN UP",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent.shade400),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Create an Account, It's free",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.greenAccent.shade200,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        RoundedTextField(
                            label: "Fullname",
                            validationMessage: 'Please enter your fullname!',
                            onChanged: (value) {
                              print(value);
                              user.fullname = value;
                            }),
                        RoundedTextField(
                            label: "Email",
                            validationMessage:
                                'Please enter your email address!',
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              user.email = value;
                            }),
                        RoundedTextField(
                            label: "Username",
                            validationMessage: 'Please enter your username!',
                            onChanged: (value) {
                              user.username = value;
                            }),
                        RoundedTextField(
                            label: "Password",
                            validationMessage: 'Please enter your password!',
                            obsureText: true,
                            onChanged: (value) {
                              user.password = value;
                            }),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        child: RoundedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _registerUser();
                            }
                          },
                          backgroundColor: Colors.white,
                          textColor: Colors.greenAccent.shade400,
                          text: 'SIGN UP',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _registerUser() async {
    bool result = await _firebaseService!
        .registerUser(user);

    if (result) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      print('Error');
    }
  }


}
