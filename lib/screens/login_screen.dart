import 'package:company_finder_app/screens/home_screen.dart';
import 'package:company_finder_app/services/firebase_service.dart';
import 'package:flutter/material.dart';
import '../components/rounded_textfield.dart';
import '../components/rounded_button.dart';
import 'package:get_it/get_it.dart';
import '../components/company_card.dart';
import '../models/user.dart' as u;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseService? _firebaseService;
  

  u.User user = u.User();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(

          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "LOG IN",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.greenAccent.shade400),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Log in with your credentials!",
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
                                label: "Email",
                                validationMessage: 'Please enter your email address!',
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  user.email = value;
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
                                  _loginUser();
                                }
                              },
                              backgroundColor: Colors.greenAccent.shade400,
                              textColor: Colors.white,
                              text: 'LOG IN',
                            ),
                          ),
                        ],
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

  void _loginUser() async {
    bool result = await _firebaseService!.loginUser(user.email.toString(), user.password.toString());
    if (result) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      print('Error');
    }
  }
}
