import 'package:app/ui/view/base_view.dart';
import 'package:app/ui/view/profile_view.dart';
import 'package:app/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  static const String id = 'home_view';
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ProfileView.id);
                },
                icon: const Icon(Icons.person),
              ),
            ],
          ),
          body: const Center(
            child: Text('Welcome to HomePage'),
          ),
        );
      },
    );
  }
}
