import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadButton extends StatefulWidget {
  final void Function(PlatformFile? file) onFileChange;
  final UploadButtonController? uploadButtonController;
  const UploadButton(
      {Key? key, required this.onFileChange, this.uploadButtonController})
      : super(key: key);

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class UploadButtonController {
  final String errorMessage;
  PlatformFile? Function()? _validate;

  UploadButtonController(this.errorMessage);

  PlatformFile? validate() => _validate?.call();
}

class _UploadButtonState extends State<UploadButton> {
  PlatformFile? _pickedFile;

  var showErrorMessage = false;
  var errorMessage = "";

  @override
  void initState() {
    initController();
    super.initState();
  }

  void initController() {
    final controller = widget.uploadButtonController;
    if (controller != null) {
      controller._validate = () => _validate(controller.errorMessage);
    }
  }

  PlatformFile? _validate(String message) {
    if (_pickedFile != null) {
      setState(() {
        errorMessage = "";
        showErrorMessage = false;
      });
    }
    setState(() {
      errorMessage = message;
      showErrorMessage = true;
    });
    return _pickedFile;
  }

  void onUploadButtonClicked() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['docx']);
    if (result == null && result?.files.isNotEmpty == true) return;
    final pickedFile = result!.files[0];
    setState(() {
      _pickedFile = pickedFile;
      widget.onFileChange(pickedFile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _pickedFile == null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _UnUploaded(
                uploadListener: onUploadButtonClicked,
              ),
              if (showErrorMessage) const SizedBox(height: 10),
              if (showErrorMessage)
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                )
            ],
          )
        : _UploadedFile(
            fileTitle: _pickedFile!.name,
            onDelete: () {
              setState(() {
                _pickedFile = null;
              });
            },
          );
  }
}

class _UploadedFile extends StatelessWidget {
  final String fileTitle;
  final void Function() onDelete;
  const _UploadedFile(
      {Key? key, required this.fileTitle, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              Text(
                "File Picked : $fileTitle",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 10),
              GestureDetector(onTap: onDelete, child: const Icon(Icons.delete))
            ]),
          ),
        ],
      );
}

class _UnUploaded extends StatelessWidget {
  final void Function() uploadListener;
  const _UnUploaded({Key? key, required this.uploadListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        onPressed: uploadListener,
        icon: const Icon(
          Icons.upload,
          color: Colors.black,
        ),
        label: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Upload",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ));
  }
}
