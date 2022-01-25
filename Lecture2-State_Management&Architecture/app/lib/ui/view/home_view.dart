// package imports
import 'package:flutter/material.dart';

// app imports
import 'package:app/enums/view_state.dart';
import 'package:app/model/data_model.dart';
import 'package:app/ui/components/custom_card.dart';
import 'package:app/ui/view/base_view.dart';
import 'package:app/ui/view/profile_view.dart';
import 'package:app/viewmodel/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  static const String id = 'home_view';
  const HomeView({Key? key}) : super(key: key);

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
          body: model.state == ViewState.IDLE
              ? RefreshIndicator(
                  onRefresh: model.getData,
                  child: ListView(
                    children: model.data.keys.map(
                      (key) {
                        DataModel data = model.data[key]!;
                        return CustomListTile(
                          flag: data.flag,
                          country: data.country,
                          active: data.active,
                          recovered: data.recovered,
                          onLongPressed: () {
                            /// If the tab is home then it will add item to favorites
                            /// else it will remove from the favorites
                            model.updateFavorites(
                                data, model.currentIndex == 0);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Country ${data.country} is ${model.currentIndex == 0 ? 'added to' : 'remove from'} favorites',
                                ),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    model.updateFavorites(
                                        data, model.currentIndex != 0);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ).toList(),
                  ),
                )
              : model.state == ViewState.ERROR
                  ? Center(
                      child: Text(model.errorMessage),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Favorites',
              ),
            ],
            currentIndex: model.currentIndex,
            onTap: (index) {
              model.currentIndex = index;
              // Dismiss the current snackbar if any
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            },
          ),
        );
      },
    );
  }
}
