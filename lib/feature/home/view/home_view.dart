import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learn/feature/home/viewModel/home_view_model.dart';

import '../../../constant/app_constant.dart';

import '../cubit/home_cubit.dart';
import '../model/data_model.dart';

import 'home_detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocProvider<HomeCubit>(
        create: (context) => HomeCubit()..fetchData(formData),
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
                body: RefreshIndicator(
                  onRefresh: () async => await context.read<HomeCubit>().fetchData(formData),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: (state is FetchLoading)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : items.isEmpty
                            ? const Center(child: Text('No Data'))
                            : Column(
                                children: [
                                  const Text("Test List"),
                                  Padding(padding: AppConstant.instance.padding.pv30),
                                  Padding(
                                    padding: AppConstant.instance.padding.ph20,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: items.length,
                                        itemBuilder: (context, index) {
                                          return _BuildCard(model: items[index], formData: formData);
                                        }),
                                  ),
                                ],
                              ),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class _BuildCard extends StatelessWidget with NavManager {
  const _BuildCard({
    Key? key,
    required DataModel model,
    required var formData,
  })  : _model = model,
        _formData = formData,
        super(key: key);

  final DataModel _model;
  final dynamic _formData;

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
                context.read<HomeCubit>().pageRoute(context, HomeDetailView(data: _model), _formData);
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
