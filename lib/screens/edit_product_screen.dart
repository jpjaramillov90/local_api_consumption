import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../services/api_service.dart';

class EditProductScreen extends StatefulWidget {
  final Producto product;

  const EditProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  late TextEditingController _codigoBarraController;
  late TextEditingController _nombreController;
  late TextEditingController _categoriaController;
  late TextEditingController _marcaController;
  late TextEditingController _precioController;

  @override
  void initState() {
    super.initState();
    _codigoBarraController = TextEditingController(
      text: widget.product.codigoBarra ?? '',
    );
    _nombreController = TextEditingController(text: widget.product.nombre);
    _categoriaController = TextEditingController(
      text: widget.product.categoria ?? '',
    );
    _marcaController = TextEditingController(text: widget.product.marca ?? '');
    _precioController = TextEditingController(
      text: widget.product.precio.toString(),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final productoActualizado = widget.product.copyWith(
          codigoBarra: _codigoBarraController.text.isEmpty
              ? null
              : _codigoBarraController.text,
          nombre: _nombreController.text,
          categoria: _categoriaController.text.isEmpty
              ? null
              : _categoriaController.text,
          marca: _marcaController.text.isEmpty ? null : _marcaController.text,
          precio: double.parse(_precioController.text),
        );

        await _apiService.updateProduct(productoActualizado);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Producto actualizado correctamente')),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al actualizar producto: $e')),
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
      appBar: AppBar(title: const Text('Editar Producto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _codigoBarraController,
                decoration: const InputDecoration(
                  labelText: 'Código de Barras',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _marcaController,
                decoration: const InputDecoration(
                  labelText: 'Marca',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _precioController,
                decoration: const InputDecoration(
                  labelText: 'Precio *',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el precio';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor ingresa un precio válido';
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
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Actualizar Producto',
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
    _codigoBarraController.dispose();
    _nombreController.dispose();
    _categoriaController.dispose();
    _marcaController.dispose();
    _precioController.dispose();
    super.dispose();
  }
}
