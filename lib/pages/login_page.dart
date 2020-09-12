import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:login/controllers/login_controller.dart';

import 'package:login/widgets/background.dart';
import 'package:login/widgets/button.dart';
import 'package:login/widgets/form_field.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController _loginController =
      Get.put<LoginController>(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // await Get.delete<LoginController>();
              Get.back();
            }),
      ),
      body: Stack(
        children: [
          Background(),
          GetBuilder<LoginController>(
              id: 'loading',
              init: _loginController,
              builder: (_) => (_.isLoading)
                  ? Center(child: CircularProgressIndicator())
                  : _loginForm(context))
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: ((_) => Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _email(),
                  SizedBox(height: 10.0),
                  _password(),
                  SizedBox(height: 10.0),
                  _loginButton(context)
                ],
              ),
            ),
          )),
    );
  }

  _email() {
    return GetBuilder<LoginController>(
        id: 'email',
        builder: ((_) => CustomFormField(
              controller: _.emailController,
              labelText: 'Email',
              icon: Icons.email,
              prefixIcon: Icon(Icons.alternate_email),
              validator: _.emailValidator,
              counterText: _.emailController.text,
            )));
  }

  _password() {
    return GetBuilder<LoginController>(
      id: 'pass',
      builder: ((_) => CustomFormField(
            controller: _.passwordController,
            labelText: 'Password',
            icon: Icons.lock,
            prefixIcon: Icon(Icons.lock_outline),
            validator: _.passwordValidator,
            counterText: _.passwordController.text,
            obscureText: _.obscureText,
            suffixIcon: IconButton(
              icon: (_.obscureText)
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),
              onPressed: () => _.obscureText = !_.obscureText,
            ),
          )),
    );
  }

  _loginButton(BuildContext context) {
    return Button(
      text: 'Sign In',
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _loginController.isLoading = true;
          FocusScope.of(context).unfocus();
          final resp = await _loginController.login();
          if (resp) {
            Get.offNamed('pruebaPage');
          }
          _loginController.isLoading = false;
        }
      },
    );
  }
}
