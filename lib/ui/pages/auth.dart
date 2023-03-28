// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously, unrelated_type_equality_checks
import 'dart:convert';

import 'package:e_commerce/helper/app_config.dart';
import 'package:e_commerce/helper/session.dart';
import 'package:e_commerce/ui/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AuthPage extends StatefulWidget {
  int authType;
  AuthPage({
    Key? key,
    required this.authType,
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int _authType = 0;

  @override
  void initState() {
    _authType = widget.authType;
    super.initState();
  }

  final pages = [
    const Loginpage(),
    const Signuppage(),
    const Forgetpassword(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: pages[_authType],
    ));
  }
}

class Loginpage extends StatefulWidget {
  const Loginpage({
    Key? key,
  }) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _checkIsLogin = false;

// @override
//   void initState() {
//     super.initState();
//     getLoginResponse();
//   }

  Future<void> getLoginResponse(String email, String password) async {
    var post_body = jsonEncode({
      "username": email,
      "password": password,
    });

    Uri url = Uri.parse("${AppConfig.baseUrl}/auth/login");
    final response = await http.post(url,
        headers: {"Accept": "*/*", 'Content-Type': 'application/json'},
        body: post_body);

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      var data = decode[AppConfig.TOKEN];
      gotoMain(data);
    }
  }

  gotoMain(String data) async {
    Session().setToken(AppConfig.TOKEN, data);
    Session().setLogin("isLogin", true);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(pagePosition: 0),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                "https://www.mobiledokan.com/wp-content/uploads/2022/09/Apple-iPhone-14-Pro-Max.jpg"),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Figma Flutter Generator TextfieldordinaryactivatedWidget - INSTANCE
                    TextFormField(
                      controller: _emailController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        labelText: 'Email address',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: _checkIsLogin,
                                onChanged: (val) {
                                  setState(() {
                                    _checkIsLogin = val!;
                                  });
                                }),
                            const Text("Save Password"),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AuthPage(authType: 2),
                                ));
                          },
                          child: const Text(
                            "Forget Password?",
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            getLoginResponse("mor_2314", "83r5^_");
                            // getLoginResponse(
                            //   _emailController.text,
                            //   _passwordController.text,
                            // );
                          });
                        }
                      },
                      child: const Text('Sign in'),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthPage(authType: 1),
                            ));
                      },
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: const TextSpan(
                          text: "Have not account?",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          children: [
                            TextSpan(
                              text: " Signup",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.green),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> getSignupResponse(
      String name, String email, String password) async {
    // var post_body = jsonEncode({
    //   "name": name,
    //   "email": email,
    //   "password": password,
    // });
    // final response = await http.post(
    //   Uri.parse('https://your-api.com/signup'),
    //   body: post_body,
    // );

    // if (response.statusCode == 200) {
    //   // Save user information locally and redirect to main screen
    // } else {
    //   // Display error message to user
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.network(
                    "https://www.mobiledokan.com/wp-content/uploads/2022/09/Apple-iPhone-14-Pro-Max.jpg"),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Figma Flutter Generator TextfieldordinaryactivatedWidget - INSTANCE
                      TextFormField(
                        controller: _nameController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _emailController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Email address',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            getSignupResponse(
                                _nameController.text,
                                _emailController.text,
                                _passwordController.text);
                          }
                        },
                        child: const Text('Sign Up'),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AuthPage(authType: 0),
                              ));
                        },
                        child: RichText(
                          textAlign: TextAlign.end,
                          text: const TextSpan(
                            text: "Have an account?",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            children: [
                              TextSpan(
                                text: " Login",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});
  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  Future<void> getForgetResponse(String email) async {
    // var post_body = jsonEncode({
    //   "email": email,
    // });
    // String baseUrl = "https://dummyjson.com";
    // Uri url = Uri.parse("$baseUrl/products");
    // final response = await http.get(
    //   url,
    //   headers: {
    //     'Content-Type': 'application/json'
    //   },
    // );
    // print(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Forget Password"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _emailController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      getForgetResponse(_emailController.text);
                    }
                  },
                  child: const Text('Reset Now'),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AuthPage(authType: 0)));
                  },
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: const TextSpan(
                      text: "Have an account?",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      children: [
                        TextSpan(
                          text: " Login",
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
