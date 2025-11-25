import 'package:flutter/material.dart';
import '../models/categoria.dart';
import '../services/api_service.dart';
import 'add_category_screen.dart';
import 'edit_category_screen.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Categoria>> _futureCategories;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _futureCategories = _loadCategories();
  }

  Future<List<Categoria>> _loadCategories() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final categories = await _apiService.getCategorias();
      setState(() {
        _isLoading = false;
      });
      return categories;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      throw e;
    }
  }

  void _refreshCategories() {
    setState(() {
      _futureCategories = _loadCategories();
    });
  }

  void _showDeleteDialog(Categoria categoria) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: Text(
            '¿Estás seguro de que quieres eliminar "${categoria.nombreCategoria}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteCategory(categoria.idCategoria);
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteCategory(int id) async {
    try {
      await _apiService.deleteCategoria(id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Categoría eliminada correctamente')),
        );
        _refreshCategories();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al eliminar: $e')));
      }
    }
  }

  Widget _buildCategoryCard(Categoria categoria) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          categoria.nombreCategoria,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditCategoryScreen(categoria: categoria),
                  ),
                );
                if (result == true) {
                  _refreshCategories();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeleteDialog(categoria),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Categorías'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshCategories,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCategoryScreen()),
          );
          if (result == true) {
            _refreshCategories();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<Categoria>>(
              future: _futureCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _refreshCategories,
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasData) {
                  final categories = snapshot.data!;
                  if (categories.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.category, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No hay categorías disponibles',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      _refreshCategories();
                    },
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return _buildCategoryCard(category);
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text('No hay datos disponibles'));
                }
              },
            ),
    );
  }
}
