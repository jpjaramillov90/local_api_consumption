import 'package:flutter/material.dart';
import '../models/categoria.dart';
import '../services/api_service.dart';

class EditCategoryScreen extends StatefulWidget {
  final Categoria categoria;

  const EditCategoryScreen({Key? key, required this.categoria})
    : super(key: key);

  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  late TextEditingController _nombreController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(
      text: widget.categoria.nombreCategoria,
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final categoriaActualizada = widget.categoria.copyWith(
          nombreCategoria: _nombreController.text,
        );

        await _apiService.updateCategoria(categoriaActualizada);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Categoría actualizada correctamente'),
            ),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al actualizar categoría: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Categoría')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la Categoría *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre de la categoría';
                  }
                  if (value.length < 2) {
                    return 'El nombre debe tener al menos 2 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Actualizar Categoría',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }
}
