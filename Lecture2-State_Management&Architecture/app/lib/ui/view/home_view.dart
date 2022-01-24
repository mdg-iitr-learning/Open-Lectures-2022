// package imports
import 'package:flutter/material.dart';

// app imports
import 'package:app/enums/view_state.dart';
import 'package:app/model/data_model.dart';
import 'package:app/ui/components/custom_card.dart';
import 'package:app/ui/view/base_view.dart';
import 'package:app/ui/view/profile_view.dart';
import 'package:app/viewmodel/home_viewmodel.dart';

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
      onModelReady: (HomeViewModel model) => model.onModelReady(),
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
          body: RefreshIndicator(
            onRefresh: () => model.getData(isReload: true),
            child: model.state == ViewState.IDLE
                ? ListView.builder(
                    itemCount: model.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      DataModel data = model.data[index];
                      return CustomListTile(
                        flag: data.flag,
                        country: data.country,
                        active: data.active,
                        recovered: data.recovered,
                      );
                    },
                  )
                : model.state == ViewState.ERROR
                    ? Center(
                        child: Text(model.errorMessage),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
          ),
        );
      },
    );
  }
}
