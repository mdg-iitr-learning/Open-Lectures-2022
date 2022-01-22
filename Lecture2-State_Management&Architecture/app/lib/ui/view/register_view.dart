import 'package:app/ui/components/custom_text_field.dart';
import 'package:app/ui/view/base_view.dart';
import 'package:app/ui/view/home_view.dart';
import 'package:app/ui/view/login_view.dart';
import 'package:app/utils/app_theme.dart';
import 'package:app/viewmodel/register_viewmodel.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  static const String id = 'register_view';
  RegisterView({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  late final RegisterViewModel _model;
  late final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        model.onModelReady();
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formkey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign Up',
                          style: AppTheme.headline1,
                        ),
                        const SizedBox(height: 40),
                        _buildNameTextField(),
                        const SizedBox(height: 20),
                        _buildEmailTextField(),
                        const SizedBox(height: 20),
                        _buildPasswordTextField(),
                        const SizedBox(height: 20),
                        _buildConfirmPasswordTextField(),
                        _buildLogInButton(),
                        _buildRegisterButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameTextField() {
    return CustomTextField(
      controller: _model.nameController,
      label: 'Name',
      hint: 'Enter your name',
      prefix: Icons.person,
      validator: _model.nameValidator,
    );
  }

  Widget _buildEmailTextField() {
    return CustomTextField(
      controller: _model.emailController,
      label: 'Email',
      hint: 'Enter your email',
      prefix: Icons.email,
      validator: _model.emailValidator,
    );
  }

  Widget _buildPasswordTextField() {
    return CustomTextField(
      controller: _model.passwordController,
      label: 'Password',
      hint: 'Enter your password',
      prefix: Icons.lock,
      isHidden: _model.isHidden,
      validator: _model.passwordValidator,
      suffix: IconButton(
        icon: _model.isHidden
            ? const Icon(Icons.visibility)
            : const Icon(Icons.visibility_off),
        onPressed: () {
          _model.isHidden = !_model.isHidden;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return CustomTextField(
      controller: _model.confirmPasswordController,
      label: 'Confirm Password',
      hint: 'Again Enter your password',
      prefix: Icons.lock,
      isHidden: true,
      validator: _model.confirmPasswordValidator,
    );
  }

  Widget _buildLogInButton() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.of(_context).pushReplacementNamed(LoginView.id);
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          'Already have an account?',
          style: AppTheme.bodyText1.copyWith(
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppTheme.primary,
              textStyle: AppTheme.button,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            onPressed: () => _formkey.currentState!.validate()
                ? _model.register().then((value) {
                    if (!value) return;
                    Navigator.of(_context).pushReplacementNamed(HomeView.id);
                  })
                : null,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Sign Up'),
            ),
          ),
        ),
      ],
    );
  }
}
