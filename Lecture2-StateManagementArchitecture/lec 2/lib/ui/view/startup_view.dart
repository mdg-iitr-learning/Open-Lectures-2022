import 'package:app/ui/view/home_view.dart';
import 'package:app/ui/view/login_view.dart';
import 'package:app/ui/view/base_view.dart';
import 'package:app/viewmodel/startup_viewmodel.dart';
import 'package:flutter/material.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpViewModel>(
      builder: (context, model, child) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      onModelReady: (model) {
        model.onModelReady().then(
              (value) => Navigator.of(context).pushReplacementNamed(
                value ? HomeView.id : LoginView.id,
              ),
            );
      },
    );
  }
}
