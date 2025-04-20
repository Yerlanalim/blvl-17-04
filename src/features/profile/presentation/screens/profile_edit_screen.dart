import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_ui_providers.dart';
import '../widgets/business_info_edit_form.dart';
import 'package:blvl_17_04_tmp/src/infrastructure/providers/profile_providers.dart';
import 'package:blvl_17_04_tmp/src/domain/models/business_info.dart';
import 'package:blvl_17_04_tmp/src/application/providers/auth_providers.dart';
import 'package:blvl_17_04_tmp/src/domain/models/user_profile.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  Map<String, dynamic>? _businessInfo;
  bool _loading = false;
  String? _error;
  BusinessInfo? _businessInfoObj;

  @override
  void initState() {
    super.initState();
    // Загружаем текущие данные пользователя через провайдер
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(currentUserProvider);
      final userId = user?.id ?? '';
      ref.read(userProfileProvider(userId)).whenData((profile) {
        setState(() {
          _name = profile?.displayName;
          _email = user?.email;
          _businessInfoObj = profile?.businessInfo;
        });
      });
    });
  }

  void _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    _formKey.currentState!.save();
    try {
      final user = ref.read(currentUserProvider);
      final userId = user?.id ?? '';
      final repo = ref.read(profileRepositoryProvider);
      // Сохраняем профиль
      await repo.updateBusinessInfo(
        userId,
        _businessInfoObj ?? BusinessInfo(companyName: '', industry: ''),
      );
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Редактировать профиль')),
      body:
          _loading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Имя'),
                        initialValue: _name,
                        onSaved: (v) => _name = v,
                        validator:
                            (v) =>
                                v == null || v.isEmpty ? 'Введите имя' : null,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        initialValue: _email,
                        onSaved: (v) => _email = v,
                        validator:
                            (v) =>
                                v == null || v.isEmpty ? 'Введите email' : null,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Бизнес-информация',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      BusinessInfoEditForm(
                        initialValue: _businessInfoObj,
                        onSaved: (val) => _businessInfoObj = val,
                      ),
                      if (_error != null)
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            _error!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _saveProfile,
                        child: Text('Сохранить'),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
