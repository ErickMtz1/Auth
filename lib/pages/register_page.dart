import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/controllers/login_register_controller.dart';

import 'package:login/widgets/background.dart';
import 'package:login/widgets/button.dart';
import 'package:login/widgets/form_field.dart';

class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginRegisterController _loginRegisterController =
      Get.put<LoginRegisterController>(LoginRegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registro'),
          centerTitle: true,
        ),
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Background(),
            SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<LoginRegisterController>(
                    id: 'loading',
                    init: _loginRegisterController,
                    builder: (_) => (_loginRegisterController.isLoading)
                        ? Center(child: CircularProgressIndicator())
                        : _loginForm(context),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _loginForm(BuildContext context) {
    return GetBuilder<LoginRegisterController>(
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
    return GetBuilder<LoginRegisterController>(
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
    return GetBuilder<LoginRegisterController>(
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
    return GetBuilder<LoginRegisterController>(
        id: 'pass',
        builder: ((_) => CustomFormField(
              controller: _.passwordController,
              obscureText: _.obscureText,
              labelText: 'Password',
              icon: Icons.lock,
              prefixIcon: Icon(Icons.lock_outline),
              validator: _.passwordRegisterValidator,
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
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child: Button(
        text: 'Registrarse',
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _loginRegisterController.isLoading = true;
            FocusScope.of(context).unfocus();
            final resp = await _loginRegisterController.createUser();
            if (resp) {
              // Redirect to new page
              // add this page in routes.dart on folder routes
            }
            _loginRegisterController.isLoading = false;
          }
        },
      ),
    );
  }
}
