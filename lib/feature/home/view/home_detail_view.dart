import 'package:fellow/fellow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/info_message.dart';
import '../../home/cubit/homedetail_cubit.dart';

import '../../../constant/app_constant.dart';
import '../../../core/crypt.dart';
import '../model/data_model.dart';

class HomeDetailView extends StatelessWidget {
  final DataModel data;

  const HomeDetailView({Key? key, required this.data})
      : _data = data,
        super(key: key);

  final DataModel _data;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController textController = TextEditingController();
    final TextEditingController dateController = TextEditingController();

    return BlocProvider<HomedetailCubit>(
      create: (context) => HomedetailCubit()
        ..setInputs(
          _data.text,
          _data.date,
          textController: textController,
          dateController: dateController,
        ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocListener<HomedetailCubit, HomedetailState>(
          listener: (context, state) {
            if (state is ShowMessage) {
              ToastMessage.showToast(state.message, state.type);
              context.pop(true);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(_data.id ?? ''),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: AppConstant.instance.padding.ph20,
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(padding: AppConstant.instance.padding.pv30),
                      _FormFields(text: textController, date: dateController),
                      _SaveButton(formKey: formKey, textController: textController, id: _data.id ?? ''),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required String id,
    required TextEditingController textController,
  })  : _formKey = formKey,
        _textController = textController,
        _id = id,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _textController;
  final String _id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomedetailCubit, HomedetailState>(
      builder: (context, state) {
        return (state is SaveLoading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    Map<String, dynamic> formData = {
                      'frmID': Crypt().encrypt("dioTestUpdate"),
                      'id': _id,
                      'text': _textController.text,
                      'token': Crypt().encrypt(AppConstant.instance.queryKey),
                    };

                    context.read<HomedetailCubit>().save(formData);
                  }
                },
                child: const Text("Kaydet"),
              );
      },
    );
  }
}

class _FormFields extends StatelessWidget {
  const _FormFields({
    Key? key,
    required TextEditingController text,
    required TextEditingController date,
  })  : _text = text,
        _date = date,
        super(key: key);

  final TextEditingController _text;
  final TextEditingController _date;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomedetailCubit, HomedetailState, bool>(
      selector: (state) => (state is SaveLoading),
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: AppConstant.instance.padding.p10,
              child: TextFormField(
                controller: _text,
                validator: (String? value) {
                  return (value == null) ? 'Boş bırakılamaz' : null;
                },
              ),
            ),
            Padding(
              padding: AppConstant.instance.padding.p10,
              child: TextFormField(
                readOnly: true,
                controller: _date,
              ),
            ),
          ],
        ).toDisabled(state);
      },
    );
  }
}
