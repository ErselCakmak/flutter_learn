import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/app_constant.dart';

import '../../cubit/home_cubit.dart';
import '../model/data_model.dart';
import '../viewModel/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()..fetchData(networkManager, formData),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is FetchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchError) {
            return Center(child: Text(state.failure.message));
          } else if (state is FetchLoaded) {
            final items = state.items;
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: items.isEmpty
                    ? const Center(child: Text('No Data'))
                    : Column(
                        children: [
                          Padding(padding: AppConstant.instance.padding.pv30),
                          Padding(
                            padding: AppConstant.instance.padding.ph20,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return _BuildCard(model: items[index]);
                                }),
                          ),
                        ],
                      ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _BuildCard extends StatelessWidget {
  const _BuildCard({
    Key? key,
    required DataModel model,
  })  : _model = model,
        super(key: key);

  final DataModel _model;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: AppConstant.instance.padding.p15,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return ListTile(
              onTap: () {
                context.read<HomeCubit>().itemDetail(_model.id!);
              },
              contentPadding: EdgeInsets.zero,
              leading: const SizedBox(
                height: double.infinity,
                child: Icon(Icons.library_books_outlined),
              ),
              trailing: const SizedBox(
                height: double.infinity,
                child: Icon(Icons.chevron_right),
              ),
              title: Text(
                _model.id ?? '',
                style: AppConstant.instance.style.f20b,
              ),
              subtitle: Text(_model.text ?? ''),
            );
          },
        ),
      ),
    );
  }
}

mixin NavManager {
  navTo(BuildContext context, Widget widget, bool fullscreen) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return widget;
        },
        fullscreenDialog: fullscreen,
        settings: const RouteSettings(),
      ),
    );
  }

  Future<T?> navToRes<T>(BuildContext context, Widget widget, bool fullscreen) {
    return Navigator.of(context).push<T>(
      MaterialPageRoute(
        builder: (context) {
          return widget;
        },
        fullscreenDialog: fullscreen,
        settings: const RouteSettings(),
      ),
    );
  }
}
