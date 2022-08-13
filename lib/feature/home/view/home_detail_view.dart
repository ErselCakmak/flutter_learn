import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/cubit/homedetail_cubit.dart';

import '../../../constant/app_constant.dart';
import '../../../core/crypt.dart';

class HomeDetailView extends StatelessWidget {
  final String id, text, date;
  const HomeDetailView({Key? key, required this.id, required this.text, required this.date})
      : _id = id,
        _text = text,
        _date = date,
        super(key: key);

  final String _id;
  final String _text;
  final String _date;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController textController = TextEditingController();
    final TextEditingController dateController = TextEditingController();

    return BlocProvider<HomedetailCubit>(
      create: (context) => HomedetailCubit()
        ..setInputs(
          _text,
          _date,
          textController: textController,
          dateController: dateController,
        ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                icon: const Icon(Icons.close)),
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
                    _SaveButton(formKey: formKey, textController: textController, id: _id),
                  ],
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
        return IgnorePointer(
          ignoring: state,
          child: AnimatedOpacity(
            duration: const Duration(seconds: 3),
            opacity: state ? 0.3 : 1,
            child: Column(
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
            ),
          ),
        );
      },
    );
  }
}
