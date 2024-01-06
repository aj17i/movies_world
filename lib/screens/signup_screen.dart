import 'package:flutter/material.dart';
import 'package:movies_world/screens/signin_screen.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const String _baseURL = 'movieaj.000webhostapp.com';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  bool _loading = false;

  void registerUser(Function(String text) update, String name, String email,
      String password) async {
    try {
      // we need to first retrieve and decrypt the key
      // send a JSON object using http post
      final response = await http
          .post(Uri.parse('http://$_baseURL/register.php'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              }, // convert the cid, name and key to a JSON object
              body: convert.jsonEncode(<String, String>{
                'username': name,
                'email': email,
                'password': password,
                'key': 'your_key'
              }))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        // if successful, call the update function
        update(response.body);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
      }
    } catch (e) {
      update(e.toString());
    }
  }

  @override
  void dispose() {
    _passwordTextController.dispose();
    _emailTextController.dispose();
    _userNameTextController.dispose();
    super.dispose();
  }

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        key: _formKey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: reusableTextField("Enter UserName",
                      Icons.person_outline, false, _userNameTextController),
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email", Icons.email_outlined, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: _loading
                      ? null
                      : () {
                          // disable button while loading

                          setState(() {
                            _loading = true;
                          });
                          registerUser(
                              update,
                              _userNameTextController.text,
                              _emailTextController.text,
                              _passwordTextController.text);
                        },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black26;
                        }
                        return Colors.white;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)))),
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                SizedBox(height: 30, ),
                Text('Please Log In after Registration!', style: TextStyle(color: Colors.white.withOpacity(0.9)),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
