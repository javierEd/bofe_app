import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' show MultipartFile;
import 'package:http_parser/http_parser.dart' show MediaType;

import '../../build_context.dart';
import '../../constants.dart';
import '../../graphql/fragments/attachment_fragment.graphql.dart';
import '../../graphql/mutations/create_attachment.graphql.dart';

class ImagePickerField extends StatelessWidget {
  ImagePickerField({
    super.key,
    this.labelText,
    this.hintText,
    this.errorText,
    Fragment$AttachmentFragment? initialValue,
    this.required = false,
    FormFieldSetter<Fragment$AttachmentFragment>? onSaved,
    FormFieldValidator<Fragment$AttachmentFragment>? validator,
  }) : initialValue = _initialValueToMulti(initialValue),
       onSaved = _onSavedToMulti(onSaved),
       validator = _validatorToMulti(validator),
       isMulti = false;

  const ImagePickerField.multi({
    super.key,
    this.labelText,
    this.hintText,
    this.errorText,
    this.initialValue = const [],
    this.required = false,
    this.onSaved,
    this.validator,
  }) : isMulti = true;

  final String? labelText;
  final String? hintText;
  final String? errorText;
  final List<Fragment$AttachmentFragment> initialValue;
  final bool required;
  final FormFieldSetter<List<Fragment$AttachmentFragment>>? onSaved;
  final FormFieldValidator<List<Fragment$AttachmentFragment>>? validator;
  final bool isMulti;

  static List<Fragment$AttachmentFragment> _initialValueToMulti(Fragment$AttachmentFragment? value) {
    return [?value];
  }

  static FormFieldSetter<List<Fragment$AttachmentFragment>>? _onSavedToMulti(
    FormFieldSetter<Fragment$AttachmentFragment>? onSaved,
  ) {
    return (value) => onSaved?.call(value?.firstOrNull);
  }

  static FormFieldValidator<List<Fragment$AttachmentFragment>>? _validatorToMulti(
    FormFieldValidator<Fragment$AttachmentFragment>? validator,
  ) {
    return (value) => validator?.call(value?.firstOrNull);
  }

  Future<void> _addImage(BuildContext context, FormFieldState<List<Fragment$AttachmentFragment>> state) async {
    final imagePicker = ImagePicker();
    final List<XFile> xFiles = [];

    if (isMulti) {
      final pickedImages = await imagePicker.pickMultiImage();

      xFiles.addAll(pickedImages);
    } else {
      final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        xFiles.add(pickedImage);
      }
    }

    for (var xFile in xFiles) {
      final file = MultipartFile.fromBytes(
        'file',
        await xFile.readAsBytes(),
        filename: xFile.name,
        contentType: xFile.mimeType != null ? MediaType.parse(xFile.mimeType!) : null,
      );

      if (!context.mounted) {
        return;
      }

      final result = await context.graphQLClient.mutate$CreateAttachment(
        Options$Mutation$CreateAttachment(variables: Variables$Mutation$CreateAttachment(file: file)),
      );
      final createdAttachment = result.parsedData?.createAttachment;

      if (createdAttachment != null && state.value?.where((att) => att.id == createdAttachment.id).isNotEmpty != true) {
        state.didChange([if (isMulti) ...state.value ?? [], createdAttachment]);
      }
    }
  }

  String? _validator(BuildContext context, List<Fragment$AttachmentFragment>? value) {
    if (required && value?.isNotEmpty != true) {
      return 'Can\'t be blank';
    }

    return validator?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<Fragment$AttachmentFragment>>(
      initialValue: initialValue,
      onSaved: onSaved,
      validator: (value) => _validator(context, value),
      builder: (state) => InkWell(
        borderRadius: borderRadius,
        child: InputDecorator(
          decoration: InputDecoration(labelText: labelText, hintText: hintText, errorText: errorText),
          child: Column(
            spacing: 4,
            children: [
              ...state.value
                      ?.map(
                        (attachment) => Row(
                          spacing: 8,
                          children: [
                            CachedNetworkImage(
                              imageUrl: attachment.thumbnailUrl.toString(),
                              width: 36,
                              height: 36,
                              fit: BoxFit.cover,
                            ),
                            Expanded(child: Text(attachment.fileName, maxLines: 1, overflow: TextOverflow.ellipsis)),
                            IconButton(
                              icon: Icon(Icons.remove_rounded),
                              tooltip: context.l10n.remove,
                              onPressed: () =>
                                  state.didChange(state.value!.where((att) => att.id != attachment.id).toList()),
                            ),
                          ],
                        ),
                      )
                      .toList() ??
                  [],
              if (isMulti || state.value?.firstOrNull == null)
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    icon: Icon(Icons.add_rounded),
                    label: Text(context.l10n.addImage),
                    onPressed: () => _addImage(context, state),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
