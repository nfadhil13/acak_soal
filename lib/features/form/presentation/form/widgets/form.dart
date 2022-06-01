part of '../form_screen.dart';

const _textFormFieldMaximumWidth = 600.0;

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _form = GlobalKey<FormState>();
  final _uploadButtonController =
      UploadButtonController("File Soal Tidak Boleh Kosong");

  var dataUjian = DataInputUjian.init();

  String? _numericFormValidator(String? value, String formName) {
    if (value == null || value.isEmpty) return "$formName tidak boleh kosong";
    final doubeOfValue = double.tryParse(value);
    if (doubeOfValue == null) return "$formName hanya bernilai number";
    if (doubeOfValue <= 0) return "$formName minimal bernilai 1";
    return null;
  }

  void _submit(BuildContext context) {
    final currentState = _form.currentState;
    final pickedFile = _uploadButtonController.validate()?.bytes;
    if (currentState != null && currentState.validate() && pickedFile != null) {
      currentState.save();
      context
          .read<FormCubit>()
          .submit(dataInputUjian: dataUjian, dataSoal: pickedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          const SizedBox(height: 35),
          Text("Form Pengacakan Soal",
              style: context.textTheme.headline2?.copyWith(
                  color: ColorTheme.primaryColor, fontWeight: FontWeight.w600)),
          const SizedBox(height: 50),
          _FormFieldWrapper(
              title: "Jumlah Peserta",
              child: BaseTextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    final doubleValue = value.toDoubleOrNull();
                    if (doubleValue != null) {
                      dataUjian = dataUjian.copyWith(
                          jumlahPeserta: doubleValue.toInt());
                    }
                  },
                  validator: (value) =>
                      _numericFormValidator(value, "Jumlah Peserta"),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly])),
          const _FormSpacing(),
          _FormFieldWrapper(
              title: "Panjang Horizontal Ruangan (meter)",
              child: BaseTextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    final doubleValue = value.toDoubleOrNull();
                    if (doubleValue != null) {
                      dataUjian = dataUjian.copyWith(
                          dataRuangan: dataUjian.dataRuangan
                              .copyWith(panjangHorizontal: doubleValue * 100));
                    }
                  },
                  validator: (value) => _numericFormValidator(
                      value, "Panjang Horizontal Ruangan"),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly])),
          const _FormSpacing(),
          _FormFieldWrapper(
              title: "Panjang Vertical Ruangan (meter)",
              child: BaseTextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    final doubleValue = value.toDoubleOrNull();
                    if (doubleValue != null) {
                      dataUjian = dataUjian.copyWith(
                          dataRuangan: dataUjian.dataRuangan
                              .copyWith(panjangVertical: doubleValue * 100));
                    }
                  },
                  validator: (value) =>
                      _numericFormValidator(value, "Panjang Vertical Ruangan"),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly])),
          const _FormSpacing(),
          _FormFieldWrapper(
              title: "Panjang Meja (cm)",
              child: BaseTextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    final doubleValue = value.toDoubleOrNull();
                    if (doubleValue != null) {
                      dataUjian = dataUjian.copyWith(
                          dataRuangan: dataUjian.dataRuangan.copyWith(
                              dataMeja: dataUjian.dataRuangan.dataMeja
                                  .copyWith(panjang: doubleValue)));
                    }
                  },
                  validator: (value) =>
                      _numericFormValidator(value, "Panjang Meja"),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly])),
          const _FormSpacing(),
          _FormFieldWrapper(
              title: "Lebar Meja (cm)",
              child: BaseTextFormField(
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  final doubleValue = value.toDoubleOrNull();
                  if (doubleValue != null) {
                    dataUjian = dataUjian.copyWith(
                        dataRuangan: dataUjian.dataRuangan.copyWith(
                            dataMeja: dataUjian.dataRuangan.dataMeja
                                .copyWith(lebar: doubleValue)));
                  }
                },
                validator: (value) =>
                    _numericFormValidator(value, "Lebar Meja"),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              )),
          const _FormSpacing(),
          _UploadButton(
            onFileChange: ((file) => {}),
            uploadButtonController: _uploadButtonController,
          ),
          const _FormSpacing(),
          _FormButton(
            onSubmit: () {
              _submit(context);
            },
          ),
          const _FormSpacing(),
        ],
      ),
    );
  }
}

class _FormButton extends StatelessWidget {
  final void Function() onSubmit;
  const _FormButton({Key? key, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _FormFieldWidthWrapper(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SecondaryButton(
          "Bantuan",
          textStyle: context.textTheme.button
              ?.copyWith(color: ColorTheme.primaryColor),
        ),
        const SizedBox(width: 20),
        PrimaryButton(
          "Submit",
          onPressed: onSubmit,
        )
      ],
    ));
  }
}

class _UploadButton extends StatelessWidget {
  final void Function(PlatformFile? file) onFileChange;
  final UploadButtonController? uploadButtonController;
  const _UploadButton(
      {Key? key, required this.onFileChange, this.uploadButtonController})
      : super(key: key);

  @override
  Widget build(BuildContext context) => _FormFieldWrapper(
      title: "File Soal Pilihan Ganda",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UploadButton(
              onFileChange: onFileChange,
              uploadButtonController: uploadButtonController),
          const SizedBox(height: 10),
          const Text("Upload file dalam bentuk format docx sesuai template"),
          const SizedBox(height: 5),
          GestureDetector(
              onTap: () {
                GenerateTemplateScreen.showAsDialog(context);
              },
              child: const Text("Download Template Disini",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.blueAccent)))
        ],
      ));
}

class _FormSpacing extends StatelessWidget {
  const _FormSpacing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const SizedBox(height: 50);
}

class _FormFieldWidthWrapper extends StatelessWidget {
  final Widget child;
  const _FormFieldWidthWrapper({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (ctx, constraint) =>
          constraint.maxWidth > _textFormFieldMaximumWidth
              ? SizedBox(width: _textFormFieldMaximumWidth, child: child)
              : child);
}

class _FormFieldWrapper extends StatelessWidget {
  final Widget child;
  final String title;
  const _FormFieldWrapper({Key? key, required this.child, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FormFieldTitle(title: title),
          const SizedBox(height: 10),
          _FormFieldWidthWrapper(child: child)
        ],
      );
}

class _FormFieldTitle extends StatelessWidget {
  final String title;
  const _FormFieldTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,
              style: context.textTheme.bodyLarge
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorTheme.primaryColor)),
            padding: const EdgeInsets.all(2),
            child: Icon(CupertinoIcons.exclamationmark,
                size: 16, color: ColorTheme.primaryColor),
          )
        ],
      );
}
