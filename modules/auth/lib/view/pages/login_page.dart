import 'dart:async';

import 'package:auth/domain/data/iauthenticate_user_data.dart';
import 'package:auth/view/cubits/login/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../cubits/login/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginCubit = Modular.get<LoginCubit>();
  var _loginData = AuthenticationViewModel(email: '', password: '');

  @override
  void initState() {
    super.initState();

    _loginCubit.stream.listen(
      (state) {
        if (state is LoginError) {
          scheduleMicrotask(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          });
        } else if (state is LoginSuccess) {
          Modular.to.pushNamedAndRemoveUntil('/home', (_) => false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: 600,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Center(
                      child: LottieBuilder.asset(
                        'assets/animations/login.json',
                        width: 300,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Continue com o seu',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      'Login',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const Spacer(flex: 2),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(Remix.mail_line),
                      ),
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: ValidationBuilder().email().required().build(),
                      onSaved: (email) {
                        _loginData = _loginData.copyWith(email: email);
                      },
                    ),
                    const Spacer(),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: Icon(Remix.lock_password_line),
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      validator:
                          ValidationBuilder().minLength(6).required().build(),
                      onSaved: (password) {
                        _loginData = _loginData.copyWith(password: password);
                      },
                    ),
                    const Spacer(),
                    BlocBuilder<LoginCubit, LoginState>(
                        bloc: _loginCubit,
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state is LoginLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      _loginCubit.authenticate(_loginData);
                                    }
                                  },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (state is LoginLoading)
                                  CupertinoActivityIndicator()
                                else ...{
                                  const Icon(Remix.key_2_fill),
                                  SizedBox(width: 8),
                                  const Text('Entrar'),
                                }
                              ],
                            ),
                          );
                        }),
                    const Spacer(),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Não tem uma conta? ',
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: 'Registre-se',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Modular.to.pushNamed('/auth/register');
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
