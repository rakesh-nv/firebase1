import 'package:firebase1/functions/authFunctions.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();
  bool isLogin = false;
  String email = '';
  String password = '';
  String username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text(
          'Email/Pass Auth',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formkey,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !isLogin
                  ? TextFormField(
                      key: const ValueKey('username'),
                      decoration: const InputDecoration(
                        hintText: "Enter Username",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.toString().length < 3) {
                          return 'Username is so small';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          username = value!;
                        });
                      },
                    )
                  : Container(),
              const SizedBox(height: 20),
              TextFormField(
                key: const ValueKey('email'),
                decoration: const InputDecoration(
                  hintText: "Enter Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (!(value.toString().contains('@'))) {
                    return 'Invalid Email';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    email = value!;
                  });
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                obscureText: true,
                key: const ValueKey('password'),
                decoration: const InputDecoration(
                  hintText: "Enter Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value.toString().length < 6) {
                    return 'Password is so small';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    password = value!;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(),
                      backgroundColor: Colors.grey[800]),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      isLogin
                          ? signin(email, password)
                          : signup(email, password);
                    }
                  },
                  child: Text(
                    isLogin ? 'Login' : 'Signup',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: isLogin
                      ? const Text("Don't have an account? Signup")
                      : const Text('Already Signed Up? Login'))
            ],
          ),
        ),
      ),
    );
  }
}
