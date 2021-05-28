import 'package:baigiamasis/modules/globals.dart';
import 'package:baigiamasis/screens/ui/home_page.dart';
import 'package:baigiamasis/screens/network/authentication.dart';
import 'package:flutter/material.dart';

String _message = '';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NT valdymas'),
      ),
      body: TextInputWidget(),
    );
  }
}

class TextInputWidget extends StatefulWidget {
  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailField.dispose();
    _passwordField.dispose();
    super.dispose();
  }

  _clearInputs() {
    _emailField.clear();
    _passwordField.clear();
  }

  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(_message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _checkLoginDetails() {
    if ((_message) == AuthMessage.loginMesage) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeView(),
        ),
      );
      _clearInputs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  autofocus: true,
                  controller: _emailField,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'El. paštas',
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Privalomas laukas';
                    } else if (isEmailValid(value.trim())) {
                      return null;
                    } else {
                      return 'Neteisingas el. pašto adreso formatas';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: _passwordField,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Slaptažodis",
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Privalomas laukas';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        overlayColor:
                            MaterialStateProperty.all(Colors.blueAccent)),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _message = await loginUser(
                          _emailField.text.trim(),
                          _passwordField.text.trim(),
                        );
                        _checkLoginDetails();
                        _showSnackbar(_message);
                      }
                    },
                    child: Text('Prisijungti'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
