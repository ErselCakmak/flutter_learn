import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/app_constant.dart';
import '../cubit/home_cubit.dart';
import '../model/data_model.dart';
import 'home_detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool dataIsLoading = false;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  void _listenScroll(BuildContext context) {
    scrollController.addListener(() {
      if (!scrollController.hasClients) return;

      // if (scrollController.position.maxScrollExtent >= (scrollController.offset * .9)) {
      //   context.read<HomeCubit>().loadData();
      // }
      if (scrollController.position.pixels > scrollController.position.maxScrollExtent) {
        context.read<HomeCubit>().loadData();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocProvider<HomeCubit>(
        create: (context) => HomeCubit()..loadData(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.firstFetched) {
              _listenScroll(context);
            }
          },
          builder: (context, state) {
            if (state.status == FetchStatus.initial) {
              return const _LoadingIndicator();
            } else if (state.status == FetchStatus.failure) {
              return const Center(child: Text("Bir hata oluştu"));
            }
            return Scaffold(
              appBar: AppBar(),
              body: SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async => context.read<HomeCubit>().refreshData(),
                  child: Padding(
                    padding: AppConstant.instance.padding.ph20,
                    child: (state.data == null)
                        ? const Center(
                            child: Text('Veri bulunamadı'),
                          )
                        : ListView.builder(
                            controller: scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.allLoaded ? (state.data?.length ?? 0) : ((state.data?.length ?? 0) + 1),
                            itemBuilder: (context, index) {
                              if (index >= (state.data?.length ?? 0)) {
                                return const _LoadingIndicator();
                              } else {
                                return _BuildCard(model: state.data![index]);
                              }
                            },
                          ),
                  ),
                ),
              ),
            );
          },
        ),
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
                context.read<HomeCubit>().pageRoute(context, HomeDetailView(data: _model));
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

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 5,
      ),
    );
  }
}
