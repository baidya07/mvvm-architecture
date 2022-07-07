import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvm_architecture/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

import '../resources/components/round_buttons.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
          title: const Text('Sign Up'),
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
                title: 'SignUp',
                loading: authViewModel.signUpLoading,
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
                    authViewModel.signupApi(data, context);
                    print('api hit');
                  }
                },
              ),
              SizedBox(
                height: height * .002,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.login);
                },
                child: InkWell(
                  child: Text('Already have an account? Log in'),
                ),
              ),
              InkWell(
                onTap: ()
                {
                  _googleSignIn
                  //google sign in
                },

                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/google_icon.svg'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Text('Sign in with Google',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}


Future<GoogleSignIn> googleSignInProcess(BuildContext context) async {
  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  String? token = googleAuth?.idToken;
  GoogleSignIn socialGoogleUser = GoogleSignIn(
    clientId: googleUser?.id,
      hostedDomain: token,
      // displayName: googleUser?.displayName,
      // email: googleUser?.email,
      // photoUrl: googleUser?.photoUrl,
  );
      Fluttertoast.showToast(
      msg: "Welcome",
      backgroundColor: Colors.green,
      textColor: Colors.white);
  return socialGoogleUser;
}

// class GoogleSignInModel {
//   final String displayName, email, photoUrl;
//   int id;
//   final String token;
//
//   GoogleSignInModel(this.displayName, this.email, this.token, this.id, this.photoUrl);
// }
