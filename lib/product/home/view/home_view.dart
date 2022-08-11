import 'package:flutter/material.dart';

import '../../../constant/app_constant.dart';
import '../model/dio_test_model.dart';
import '../viewModel/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: items.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: AppConstant.instance.color.light,
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _DioTestCard(model: items[index]);
              }),
    );
  }
}

class _DioTestCard extends StatelessWidget {
  const _DioTestCard({
    Key? key,
    required DioTestModel model,
  })  : _model = model,
        super(key: key);

  final DioTestModel _model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppConstant.instance.padding.ph15 + AppConstant.instance.padding.pv15,
        child: ListTile(
          title: Text(
            _model.iD ?? '',
            style: AppConstant.instance.style.f20b,
          ),
          subtitle: Text(_model.text ?? ''),
        ),
      ),
    );
  }
}
