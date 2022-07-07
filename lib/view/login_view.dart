import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_architecture/resources/components/round_buttons.dart';
import 'package:mvvm_architecture/view_model/auth_view_model.dart';

import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your Email',
                    prefixIcon: Icon(Icons.alternate_email)),
                onFieldSubmitted: (valu) {
                  Utils.fieldFocusChange(
                      context, emailFocusNode, passwordFocusNode);
                },
              ),
              ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: _obsecurePassword.value,
                      focusNode: passwordFocusNode,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: InkWell(
                            onTap: () {
                              _obsecurePassword.value =
                                  !_obsecurePassword.value;
                            },
                            child: Icon(_obsecurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility)),
                      ),
                    );
                  }),
              SizedBox(
                height: height * .085,
              ),
              RoundButton(
                title: 'Login',
                loading: authViewModel.loading,
                onPress: (){
                  if(_emailController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please enter email', context);
                  }else if(_passwordController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please enter password', context);
                  }else if(_passwordController.text.length < 6){
                    Utils.flushBarErrorMessage('Password should be more than 6 digits', context);
                  }else{
                    Map data = {
                      'email' : _emailController.text.toString(),
                      'password' : _passwordController.text.toString(),
                    };
                    authViewModel.loginApi(data, context);
                    print('api hit');
                  }
                },
              ),
              SizedBox(
                height: height * .002,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.signup);
                },
                  child: Text('Don\'t have an account? sign up'),
              ),
            ],
          ),
        ));
  }
}
