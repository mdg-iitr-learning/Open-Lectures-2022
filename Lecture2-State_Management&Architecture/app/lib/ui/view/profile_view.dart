import 'package:app/ui/view/base_view.dart';
import 'package:app/ui/view/login_view.dart';
import 'package:app/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  static const String id = 'profile_view';
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile View'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () async {
                  await model.signout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginView.id,
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          body: const Center(
            child: Text('Welcome to ProfilePage'),
          ),
        );
      },
    );
  }
}
