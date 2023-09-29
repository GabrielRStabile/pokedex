import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../domain/data/iregister_user_data.dart';
import '../cubits/register/register_cubit.dart';
import '../cubits/register/register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _registerCubit = Modular.get<RegisterCubit>();
  var _registerData = RegisterViewModel(email: '', password: '');

  @override
  void initState() {
    super.initState();

    _registerCubit.stream.listen(
      (state) {
        if (state is RegisterError) {
          scheduleMicrotask(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          });
        } else if (state is RegisterSuccess) {
          Modular.to.pushNamedAndRemoveUntil('/home/', (_) => false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          onPressed: () => Modular.to.pop(),
        ),
      ),
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
                      child: Image.asset(
                        'assets/images/register.png',
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Continue com o seu',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      'Registro',
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
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: ValidationBuilder().email().required().build(),
                      onSaved: (email) {
                        _registerData = _registerData.copyWith(email: email);
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
                        _registerData =
                            _registerData.copyWith(password: password);
                      },
                    ),
                    const Spacer(),
                    BlocBuilder<RegisterCubit, RegisterState>(
                        bloc: _registerCubit,
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state is RegisterLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      _registerCubit.register(_registerData);
                                    }
                                  },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (state is RegisterLoading)
                                  CupertinoActivityIndicator()
                                else ...{
                                  const Icon(Remix.login_circle_line),
                                  SizedBox(width: 8),
                                  const Text('Criar conta'),
                                }
                              ],
                            ),
                          );
                        }),
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
