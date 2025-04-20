import 'package:flutter/material.dart';
import 'package:blvl_17_04_tmp/src/domain/models/business_info.dart';

class BusinessInfoEditForm extends StatefulWidget {
  final BusinessInfo? initialValue;
  final ValueChanged<BusinessInfo> onSaved;
  const BusinessInfoEditForm({
    Key? key,
    this.initialValue,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<BusinessInfoEditForm> createState() => _BusinessInfoEditFormState();
}

class _BusinessInfoEditFormState extends State<BusinessInfoEditForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _companyNameController;
  late TextEditingController _industryController;
  late TextEditingController _companySizeController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _companyNameController = TextEditingController(
      text: widget.initialValue?.companyName ?? '',
    );
    _industryController = TextEditingController(
      text: widget.initialValue?.industry ?? '',
    );
    _companySizeController = TextEditingController(
      text: widget.initialValue?.companySize?.toString() ?? '',
    );
    _locationController = TextEditingController(
      text: widget.initialValue?.location ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialValue?.description ?? '',
    );
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _industryController.dispose();
    _companySizeController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSave() {
    final businessInfo = BusinessInfo(
      companyName: _companyNameController.text,
      industry: _industryController.text,
      companySize: int.tryParse(_companySizeController.text),
      location: _locationController.text,
      description: _descriptionController.text,
    );
    widget.onSaved(businessInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _companyNameController,
          decoration: InputDecoration(labelText: 'Название бизнеса'),
        ),
        TextFormField(
          controller: _industryController,
          decoration: InputDecoration(labelText: 'Сфера деятельности'),
        ),
        TextFormField(
          controller: _companySizeController,
          decoration: InputDecoration(labelText: 'Размер компании'),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: _locationController,
          decoration: InputDecoration(labelText: 'Локация'),
        ),
        TextFormField(
          controller: _descriptionController,
          decoration: InputDecoration(labelText: 'Описание'),
        ),
        // onSaved вызывается из родительской формы
      ],
    );
  }
}
