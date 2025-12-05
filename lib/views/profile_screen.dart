import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_scaffold.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      final String name = _nameCtrl.text.trim();
      final String email = _emailCtrl.text.trim();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved profile: $name — $email')),
      );
    }
  }

  String? _validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'Enter a name';
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Enter an email';
    final email = v.trim();
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(email)) return 'Enter a valid email';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Profile / Sign in',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                key: const ValueKey('profile_name'),
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: _validateName,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              TextFormField(
                key: const ValueKey('profile_email'),
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                key: const ValueKey('profile_save'),
                onPressed: _save,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
