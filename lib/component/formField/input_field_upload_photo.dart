import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:research_component/constant/constants_color.dart';
import 'package:research_component/constant/constants_styling.dart';
import '../../camera_page.dart';
import 'form_field_config.dart';

class InputFieldImageUploadWidget extends StatefulWidget {
  final FormFieldConfig fieldConfig;
  final List<CameraDescription> cameras;
  final void Function(XFile?)? onImagePicked;
  final String? errorText;

  const InputFieldImageUploadWidget({
    Key? key,
    required this.fieldConfig,
    required this.cameras,
    this.onImagePicked,
    this.errorText,
  }) : super(key: key);

  @override
  State<InputFieldImageUploadWidget> createState() => _InputFieldImageUploadWidgetState();
}

class _InputFieldImageUploadWidgetState extends State<InputFieldImageUploadWidget> {
  XFile? _imageFile;

  Future<void> _openCamera() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraPage(cameras: widget.cameras),
      ),
    );

    if (result != null && result is XFile) {
      setState(() {
        _imageFile = result;
      });
      widget.onImagePicked?.call(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = widget.fieldConfig.labelField;
    final helper = widget.fieldConfig.helper;
    final isRequired = widget.fieldConfig.isRequired;
    final isShowLabel = widget.fieldConfig.isShowLabel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && isShowLabel)
          Column(
            children: [
              Row(
                children: [
                  Text(
                    label,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: ConstantsColor.PRIMARY.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (isRequired)
                    const Text(
                      "*",
                      style: TextStyle(fontSize: 14, color: Colors.red),
                    ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        GestureDetector(
          onTap: _openCamera,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(
                  color: widget.errorText != null
                      ? ConstantsStyling.errorBorder.borderSide.color
                      : ConstantsColor.PRIMARY.shade200,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _imageFile == null
                  ? Center(
                child: Icon(Icons.camera_alt,
                    size: 40, color: ConstantsColor.PRIMARY),
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(_imageFile!.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.errorText!,
            style: TextStyle(
              color: Colors.red.shade700,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        if (helper != null) ...[
          const SizedBox(height: 6),
          Text(
            helper,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
        const SizedBox(height: 18),
      ],
    );
  }
}
