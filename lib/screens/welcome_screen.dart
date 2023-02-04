import 'package:company_finder_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'registration_screen.dart';
import '../components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              child: Icon(
                Icons.business_rounded,
                size: 50.0,
                color: Colors.greenAccent.shade400,
              ),
            ),
            Text(
              'COMPANY\nFINDER',
              style: TextStyle(
                fontFamily: 'Roboto - Black',
                fontSize: 50.0,
                color: Colors.greenAccent.shade400,
              ),
            ),
            
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 10.0),
          child: RoundedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));              
            },
            textColor: Colors.white,
            backgroundColor: Colors.greenAccent.shade400,
            text: 'LOG IN',
          )
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
          child: RoundedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationScreen()));
            },
            backgroundColor: Colors.white,
            textColor: Colors.greenAccent.shade400,
            text: 'SIGN UP',
          ),
        ),
      ],
    );
  }
}
