import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:login/controllers/register_controller.dart';

import 'package:login/widgets/background.dart';
import 'package:login/widgets/button.dart';
import 'package:login/widgets/form_field.dart';

class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegisterController _registerController =
      Get.put<RegisterController>(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register Page'),
        ),
        body: Stack(
          children: [
            Background(),
            GetBuilder<RegisterController>(
              id: 'loading',
              init: _registerController,
              builder: (_) => (_registerController.isLoading)
                  ? Center(child: CircularProgressIndicator())
                  : _loginForm(context),
            )
          ],
        ));
  }

  Widget _loginForm(BuildContext context) {
    return GetBuilder<RegisterController>(
      builder: ((_) => Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _name(),
                  SizedBox(height: 10.0),
                  _email(),
                  SizedBox(height: 10.0),
                  _password(),
                  SizedBox(height: 10.0),
                  _registerButton(context)
                ],
              ),
            ),
          )),
    );
  }

  _name() {
    return GetBuilder<RegisterController>(
        id: 'name',
        builder: ((_) => CustomFormField(
              controller: _.nameController,
              labelText: 'Name',
              icon: Icons.person,
              counterText: _.nameController.text,
              prefixIcon: Icon(Icons.person_outline),
              validator: _.nameValidator,
            )));
  }

  _email() {
    return GetBuilder<RegisterController>(
        id: 'email',
        builder: ((_) => CustomFormField(
              controller: _.emailController,
              labelText: 'Email',
              icon: Icons.email,
              prefixIcon: Icon(Icons.alternate_email),
              validator: _.emailValidator ,
              counterText: _.emailController.text,
            )));
  }

  _password() {
    return GetBuilder<RegisterController>(
        id: 'pass',
        builder: ((_) => CustomFormField(
              controller: _.passwordController,
              labelText: 'Password',
              icon: Icons.lock,
              prefixIcon: Icon(Icons.lock_outline),
              validator: _.passwordValidator,
              counterText: _.passwordController.text,
              suffixIcon: IconButton(
                icon: (_.obscureText)
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
                onPressed: () => _.obscureText = !_.obscureText,
              ),
            )));
  }

  _registerButton(BuildContext context) {
    return Button(
      text: 'Sign In',
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _registerController.isLoading = true;
          FocusScope.of(context).unfocus();
          final resp = await _registerController.createUser();
          if (resp) {
            Get.offNamed('pruebaPage');
          }
          _registerController.isLoading = false;
        }
      },
    );
  }
}
