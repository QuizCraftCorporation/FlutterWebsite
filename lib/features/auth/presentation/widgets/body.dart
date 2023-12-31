import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/presentation/custom_error_widget.dart';
import 'package:capstone_project/core/presentation/loading.dart';
import 'package:capstone_project/core/presentation/text_field_circular.dart';
import 'package:capstone_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _secondPasswordController;
  late TextEditingController _firstNameController;
  late TextEditingController _secondNameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _secondPasswordController = TextEditingController();
    _firstNameController = TextEditingController();
    _secondNameController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _secondPasswordController.dispose();
    _firstNameController.dispose();
    _secondNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            AutoRouter.of(context).replaceNamed('/my_quizzes');
          }
        },
        builder: (context, state) {
          if (state is AuthLogin) {
            return SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                    ),
                    Container(
                      width: min(250, MediaQuery
                          .of(context)
                          .size
                          .width / 2),
                      margin: const EdgeInsets.only(
                        top: 25,
                      ),
                      child: TextFieldCircular(
                          controller: _usernameController,
                          lines: 1,
                          hint: 'Username'),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 15,
                      ),
                      width: min(250, MediaQuery
                          .of(context)
                          .size
                          .width / 2),
                      child: TextFieldCircular(
                        controller: _passwordController,
                        lines: 1,
                        hint: 'Password',
                        password: true,
                      ),
                    ),
                    TextButton(onPressed: () =>
                        BlocProvider.of<AuthCubit>(context).regView(),
                      child: const Text("Don't have an account? Register", style: TextStyle(fontSize: 20)),),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_usernameController.text.length < 4 ||
                              _passwordController.text.length < 4) {
                            showDialog(
                              context: context, builder: (context) {
                              return const AlertDialog(
                                title: Text('Error'),
                                content: Text('Username and passwords should have at least 4 symbols'),
                              );
                            },);
                          } else {
                            BlocProvider.of<AuthCubit>(context).login(
                                _usernameController.text,
                                _passwordController.text);
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is AuthLoginProcess) {
            return const Loading(text: 'Entering');
          }
          if (state is AuthSuccess) {
            // Everything fine
          }
          if (state is AuthError) {
            return AlertDialog(
              title: const Text('Error'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No username with such password'),
                  TextButton(onPressed: () => BlocProvider.of<AuthCubit>(context).loginView(), child: const Text('Login again'))
                ],
              ),
            );
          }
          if (state is AuthRegister) {
            return SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      child: const Text(
                        'Registration',
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                    ),
                    Container(
                      width: min(250, MediaQuery
                          .of(context)
                          .size
                          .width / 2),
                      margin: const EdgeInsets.only(
                        top: 25,
                      ),
                      child: TextFieldCircular(
                          controller: _usernameController,
                          lines: 1,
                          hint: 'Username'),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 15,
                      ),
                      width: min(250, MediaQuery
                          .of(context)
                          .size
                          .width / 2),
                      child: TextFieldCircular(
                        controller: _passwordController,
                        lines: 1,
                        hint: 'Password',
                        password: true,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 15,
                      ),
                      width: min(250, MediaQuery
                          .of(context)
                          .size
                          .width / 2),
                      child: TextFieldCircular(
                        controller: _secondPasswordController,
                        lines: 1,
                        hint: 'Confirm password',
                        password: true,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 15,
                      ),
                      width: min(250, MediaQuery
                          .of(context)
                          .size
                          .width / 2),
                      child: TextFieldCircular(
                        controller: _firstNameController,
                        lines: 1,
                        hint: 'First Name',
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 15,
                      ),
                      width: min(250, MediaQuery
                          .of(context)
                          .size
                          .width / 2),
                      child: TextFieldCircular(
                        controller: _secondNameController,
                        lines: 1,
                        hint: 'Last Name',
                      ),
                    ),
                    TextButton(onPressed: () =>
                        BlocProvider.of<AuthCubit>(context).loginView(),
                      child: const Text("Have an account? Login", style: TextStyle(fontSize: 20)),),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_usernameController.text.length < 4 ||
                              _passwordController.text.length < 4
                          ) {
                            showDialog(
                              context: context, builder: (context) {
                              return const AlertDialog(
                                title: Text('Error'),
                                content: Text('Username and passwords should have at least 4 symbols'),
                              );
                            },);
                          } else if (_passwordController.text !=
                              _secondPasswordController.text){
                            showDialog(
                              context: context, builder: (context) {
                              return const AlertDialog(
                                title: Text('Error'),
                                content: Text('Check passwords'),
                              );
                            },);
                          } else {
                            BlocProvider.of<AuthCubit>(context).register(
                                _usernameController.text,
                                _passwordController.text,
                                _firstNameController.text,
                                _secondNameController.text);
                            _usernameController.text = '';
                            _passwordController.text = '';
                            _firstNameController.text = '';
                            _secondNameController.text = '';
                            _secondPasswordController.text = '';
                          }
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is AuthRegisterProcess) {
            return const Loading(text: 'register');
          }
          if (state is AuthRegisterSuccess) {
            return const Loading(text: '');
          }
          if (state is AuthRegisterError) {
            return CustomError(message: state.message);
          }
          return const Loading(text: '');
        },
      ),
    );
  }
}
