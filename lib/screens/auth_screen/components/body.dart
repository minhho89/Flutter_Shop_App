import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/models/http_exception.dart';

import '../../../providers/Auth.dart';
import '../../../widgets/neumorphic_text_input_field.dart';

enum AuthMode {
  Login,
  SignUp,
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Hello!'),
            const Text('Welcome back'),
            Container(
              margin: const EdgeInsets.all(30),
              // neumorphic design shadow
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    // top bottom right
                    BoxShadow(
                      color: Colors.grey.shade600,
                      offset: const Offset(5, 5),
                      blurRadius: 15,
                    ),
                    // bottom top left
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, -5),
                      blurRadius: 15,
                    ),
                  ]),
              child: Card(
                color: Colors.grey[300],
                elevation: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        NeumorphicTextInputField(
                          textFormField: TextFormField(
                            onSaved: (value) => _authData['email'] = value!,
                            decoration: buildNeumorphicInputDecoration('email'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              bool isValid = RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(value!);
                              if (value.isEmpty || !isValid) {
                                return 'Invalid email!';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        NeumorphicTextInputField(
                          textFormField: TextFormField(
                            controller: _passwordController,
                            onSaved: (value) => _authData['password'] = value!,
                            decoration:
                                buildNeumorphicInputDecoration('Password'),
                            obscureText: true,
                          ),
                        ),
                        if (_authMode == AuthMode.SignUp)
                          _isLoading
                              ? const CircularProgressIndicator()
                              : Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    NeumorphicTextInputField(
                                      textFormField: TextFormField(
                                        onSaved: (value) =>
                                            _authData['password'] = value!,
                                        decoration:
                                            buildNeumorphicInputDecoration(
                                                'confirm password'),
                                        obscureText: true,
                                        validator: _authMode == AuthMode.SignUp
                                            ? (value) {
                                                if (value !=
                                                    _passwordController.text) {
                                                  return 'Passwords do not match';
                                                }
                                              }
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                        TextButton(
                          onPressed: () => _submit(),
                          child: Text(
                              _authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP'),
                        ),
                        TextButton(
                          onPressed: _switchAuthMode,
                          child: Text(
                              '${_authMode == AuthMode.Login ? 'SIGN UP' : 'LOGIN'}'
                              ' INSTEAD'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid case
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    final _auth = Provider.of<Auth>(context, listen: false);
    try {
      if (_authMode == AuthMode.Login) {
        await _auth.login(_authData['email']!, _authData['password']!);
      } else {
        await _auth.signup(_authData['email']!, _authData['password']!);
      }
    } on HttpException catch (error) {
      var errorMessage = error.toString();
      switch (errorMessage) {
        case 'EMAIL_NOT_FOUND':
          {
            errorMessage = 'Could not find a user with this email';
          }
          break;
        case 'INVALID_PASSWORD':
          {
            errorMessage = 'Invalid Password';
          }
          break;
        case 'USER_DISABLED':
          {
            errorMessage = 'Your account has been disabled';
          }
          break;
        case 'EMAIL_EXISTS':
          {
            errorMessage = 'The email address is already in used';
            break;
          }
        default:
          errorMessage = 'Authentication failed';
      }
      showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Could not authenticate you. Please try again later';
      showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occured!'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Okay'),
          )
        ],
      ),
    );
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }
}
