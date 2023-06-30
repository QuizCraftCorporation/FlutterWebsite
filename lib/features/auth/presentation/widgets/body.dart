import 'dart:math';
import 'package:auto_route/auto_route.dart';
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

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            // TODO: navigate to Crafter
            AutoRouter.of(context).replaceNamed('/crafter');
          }
        },
        builder: (context, state) {
          if (state is AuthInitial) {
            return SingleChildScrollView(
              child: SizedBox(
                // TODO: remove this fixed width
                width: MediaQuery.of(context).size.width - 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: min(250, MediaQuery.of(context).size.width / 2),
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
                      width: min(250, MediaQuery.of(context).size.width / 2),
                      child: TextFieldCircular(
                        controller: _passwordController,
                        lines: 1,
                        hint: 'Password',
                        password: true,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_usernameController.text.length < 4 ||
                              _passwordController.text.length < 4) {
                            // TODO: inform about error
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
            return const Loading(text: 'Try to login');
          }
          if (state is AuthSuccess) {
            // Everything fine
          }
          if (state is AuthError) {
            // TODO: handle errors
          }
          return Container();
        },
      ),
    );
  }
}
