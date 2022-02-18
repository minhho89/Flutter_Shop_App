import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/consts/constants.dart';
import 'package:shop_app_nojson/models/http_exception.dart';

import '../../../providers/Auth.dart';
import '../../../widgets/neumorphics/neumorphic_button.dart';
import '../../../widgets/neumorphics/neumorphic_card.dart';
import '../../../widgets/neumorphics/neumorphic_text_input_field.dart';

enum AuthMode {
  Login,
  SignUp,
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  // Animation
  late AnimationController _animationController;
  late Animation<Size> _heightAnimation;

  @override
  void dispose() {
    _animationController.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _heightAnimation = Tween<Size>(
            begin: const Size(double.infinity, 300),
            end: const Size(double.infinity, 390))
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeIn));
    // _heightAnimation.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildLogo(),
            buildGreetings(context),
            NeumorphicCard(
              shadowBlur: 15,
              child: Card(
                color: kBackgroundColor,
                elevation: 0,
                child: AnimatedBuilder(
                  animation: _heightAnimation,
                  builder: (context, ch) => Container(
                      height: _heightAnimation.value.height,
                      constraints: BoxConstraints(
                          minHeight: _heightAnimation.value.height),
                      width: deviceSize.width * 0.75,
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      child: ch),
                  child: buildForm(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            NeumorphicTextInputField(
              textFormField: TextFormField(
                onSaved: (value) => _authData['email'] = value!,
                decoration: buildNeumorphicInputDecoration('Email'),
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
                decoration: buildNeumorphicInputDecoration('Password'),
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
                            onSaved: (value) => _authData['password'] = value!,
                            decoration: buildNeumorphicInputDecoration(
                                'confirm password'),
                            obscureText: true,
                            validator: _authMode == AuthMode.SignUp
                                ? (value) {
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
            const SizedBox(
              height: 20,
            ),
            NeumorphicButton(
              borderRadius: BorderRadius.circular(8.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: 40,
              onPressed: _submit,
              child: Text(
                _authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            TextButton(
              onPressed: _switchAuthMode,
              child: Text(
                '${_authMode == AuthMode.Login ? 'SIGN UP' : 'LOGIN'}'
                ' INSTEAD',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle1!.color,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column buildGreetings(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
          alignment: Alignment.topLeft,
          child: Text(
            'Hello!',
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline4!.fontSize,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          alignment: Alignment.topLeft,
          child: Text(
            'Welcome back',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Container buildLogo() {
    return Container(
      alignment: Alignment.centerRight,
      child: NeumorphicCard(
        shadowBlur: 20,
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[300],
          ),
          child: Image.asset(
            'assets/img/logo.png',
          ),
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
      _animationController.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _animationController.reverse();
    }
  }
}
