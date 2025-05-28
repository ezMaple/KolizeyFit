import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../l10n/app_localizations.dart';

class ParametersScreen extends StatefulWidget {
  const ParametersScreen({super.key});

  @override
  State<ParametersScreen> createState() => _ParametersScreenState();
}

class _ParametersScreenState extends State<ParametersScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'chest': TextEditingController(),
    'hips': TextEditingController(),
    'height': TextEditingController(),
    'neck': TextEditingController(),
    'biceps': TextEditingController(),
    'weight': TextEditingController(),
  };

  bool _isLoading = true;
  bool _isEditing = false;
  bool _hasParams = false;

  @override
  void initState() {
    super.initState();
    _loadParameters();
  }

  Future<void> _loadParameters() async {
    try {
      final data = await ApiService.getParameters();
      _hasParams = true;
      _controllers.forEach((key, controller) {
        controller.text = data[key].toString();
      });
    } catch (_) {
      _hasParams = false;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _submit() async {
    final local = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) return;

    final body = _controllers.map(
      (key, controller) =>
          MapEntry(key, double.tryParse(controller.text.trim()) ?? 0.0),
    );

    setState(() => _isLoading = true);

    try {
      if (_hasParams) {
        await ApiService.updateParameters(body);
      } else {
        await ApiService.createParameters(body);
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(CustomSnackBar(message: local.parametersSaved));

      setState(() => _isEditing = false);
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(CustomSnackBar(message: e.toString(), isError: true));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildField(String label, String key) {
    final local = AppLocalizations.of(context)!;

    return TextFormField(
      controller: _controllers[key],
      enabled: _isEditing,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return local.fieldRequired(label);
        }
        final num = double.tryParse(value.trim());
        if (num == null || num <= 0) return local.invalidFieldValue;
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(title: Text(local.parametersTitle)),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      _buildField(local.chestLabel, 'chest'),
                      const SizedBox(height: 20),
                      _buildField(local.hipsLabel, 'hips'),
                      const SizedBox(height: 20),
                      _buildField(local.heightLabel, 'height'),
                      const SizedBox(height: 20),
                      _buildField(local.neckLabel, 'neck'),
                      const SizedBox(height: 20),
                      _buildField(local.bicepsLabel, 'biceps'),
                      const SizedBox(height: 20),
                      _buildField(local.weightLabel, 'weight'),
                      const SizedBox(height: 24),
                      _isEditing
                          ? CustomButton(
                            text: local.saveButton,
                            onPressed: _submit,
                          )
                          : CustomButton(
                            text:
                                _hasParams
                                    ? local.editButton
                                    : local.createButton,
                            onPressed: () {
                              setState(() => _isEditing = true);
                            },
                          ),
                    ],
                  ),
                ),
              ),
    );
  }
}
