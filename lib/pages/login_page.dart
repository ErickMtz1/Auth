import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:login/controllers/login_register_controller.dart';

import 'package:login/widgets/background.dart';
import 'package:login/widgets/button.dart';
import 'package:login/widgets/form_field.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginRegisterController _loginRegisterController =
      Get.put<LoginRegisterController>(LoginRegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingresar'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // await Get.delete<LoginRegisterController>();
              Get.back();
            }),
      ),
      body: Stack(
        children: [
          Background(),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                _image(),
            GetBuilder<LoginRegisterController>(
                id: 'loading',
                init: _loginRegisterController,
                builder: (_) => (_.isLoading)
                    ? Center(child: CircularProgressIndicator())
                    : _loginForm(context))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _image() {
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.07),
      child: Hero(
        tag: 'logo',
        child: Image(
          image: AssetImage('assets/e-Tuux.png'),
          width: Get.width,
          height: Get.height * 0.3,
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return GetBuilder<LoginRegisterController>(
      builder: ((_) => Container(
        // margin: EdgeInsets.only(top: Get.height * 0.2),
        child: Form(
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
            ),
      )),
    );
  }

  _email() {
    return GetBuilder<LoginRegisterController>(
        id: 'email',
        builder: ((_) => CustomFormField(
              controller: _.emailController,
              labelText: 'Correo',
              icon: Icons.email,
              prefixIcon: Icon(Icons.alternate_email),
              validator: _.emailValidator,
              // counterText: _.emailController.text,
            )));
  }

  _password() {
    return GetBuilder<LoginRegisterController>(
      id: 'pass',
      builder: ((_) => CustomFormField(
            controller: _.passwordController,
            labelText: 'Contraseña',
            icon: Icons.lock,
            prefixIcon: Icon(Icons.lock_outline),
            validator: _.passwordValidator,
            // counterText: _.passwordController.text,
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
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Button(
        text: 'Iniciar sesión',
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _loginRegisterController.isLoading = true;
            FocusScope.of(context).unfocus();
            final resp = await _loginRegisterController.login();
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
