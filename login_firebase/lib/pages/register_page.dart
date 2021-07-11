//something like "LoginPage" !

import 'package:login_firebase/blocs/authentication_bloc.dart';
import 'package:login_firebase/blocs/register_bloc.dart';
import 'package:login_firebase/events/authentication_event.dart';
import 'package:login_firebase/events/register_event.dart';
import 'package:login_firebase/repositories/user_repository.dart';
import 'package:login_firebase/states/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'buttons/register_button.dart';

class RegisterPage extends StatefulWidget {
  final UserRepository _userRepository;
  RegisterPage({required Key key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  UserRepository get _userRepository => widget._userRepository;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isValidEmailAndPassword && isPopulated && !state.isSubmitting;
  }
  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, registerState) {
              if (registerState.isFailure) {
                print('Registration Failed');
              } else if (registerState.isSubmitting) {
                print('Registration in progress...');
              } else if (registerState.isSuccess) {
                BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationEventLoggedIn());
              }
              return Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        autovalidateMode: AutovalidateMode.always, controller: _emailController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (_) {
                          return !registerState.isValidEmail ? 'Invalid Email' : null;
                        },
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.always, controller: _passwordController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        autocorrect: false,
                        validator: (_) {
                          return !registerState.isValidPassword ? 'Invalid Password' : null;
                        },
                      ),
                      Padding(padding: EdgeInsets.only(top: 20),),
                      RegisterButton(
                          onPressed: () {
                            if(isRegisterButtonEnabled(registerState)) {
                              _registerBloc.add(
                                RegisterEventPressed(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                            }
                          }
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}