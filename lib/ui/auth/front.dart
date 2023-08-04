import 'package:flutter/material.dart';
import 'package:todo/widget/round_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrangeAccent,
        title: Center(child: Text("Login")),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      cursorColor: Colors.deepOrangeAccent,
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Enter your email",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          )),
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      cursorColor: Colors.deepOrangeAccent,
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter password",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )),
            RoundButton("Login", () {}),
          ],
        ),
      ),
    );
  }
}
