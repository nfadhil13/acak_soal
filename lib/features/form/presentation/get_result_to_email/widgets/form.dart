part of '../get_result_to_email_screen.dart';

const _textFormFieldMaximumWidth = 600.0;

class _Form extends StatefulWidget {
  final BuildContext parentContext;
  final List<Widget> widget;
  final String soalPath;
  const _Form(
      {Key? key,
      required this.parentContext,
      required this.widget,
      required this.soalPath})
      : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _form = GlobalKey<FormState>();
  var email = "";

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) return "email tidak boleh kosong";
    if (value.isEmail()) return null;
    return "Field ini harus diisi email";
  }

  void _submit(BuildContext context, BuildContext parentContext) {
    final currentState = _form.currentState;
    if (currentState != null && currentState.validate()) {
      currentState.save();
      context
          .read<GetResultToEmailCubit>()
          .submit(email, widget.soalPath, parentContext, widget.widget);
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
          const _FormSpacing(),
          _FormFieldWrapper(
            title: "Email",
            child: BaseTextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) {
                if (value != null) email = value;
              },
              validator: (value) => _emailValidator(value),
            ),
          ),
          const _FormSpacing(),
          _FormButton(onSubmit: () {
            _submit(context, widget.parentContext);
          })
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
          "Cancel",
          textStyle: context.textTheme.button
              ?.copyWith(color: ColorTheme.primaryColor),
          onPress: () {
            Navigator.of(context).pop();
          },
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

class _FormSpacing extends StatelessWidget {
  const _FormSpacing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const SizedBox(height: 30);
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
