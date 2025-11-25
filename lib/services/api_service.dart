import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/producto.dart';
import '../models/categoria.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api';

  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final http.Client client = http.Client();

  // PRODUCTOS

  // GET - Obtener todos los productos
  Future<List<Producto>> getProducts() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((json) => Producto.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar productos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // GET - Obtener un producto por ID
  Future<Producto> getProductById(int id) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/products/$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Producto.fromJson(jsonResponse);
      } else if (response.statusCode == 404) {
        throw Exception('Producto no encontrado');
      } else {
        throw Exception('Error al cargar producto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // POST - Crear nuevo producto
  Future<Producto> createProduct(Producto producto) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/products'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(producto.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Producto.fromJson(jsonResponse);
      } else {
        throw Exception('Error al crear producto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // PUT - Actualizar producto
  Future<Producto> updateProduct(Producto producto) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl/products/${producto.idProducto}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(producto.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Producto.fromJson(jsonResponse);
      } else {
        throw Exception('Error al actualizar producto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // DELETE - Eliminar producto
  Future<void> deleteProduct(int id) async {
    try {
      final response = await client.delete(Uri.parse('$baseUrl/products/$id'));

      if (response.statusCode != 200) {
        throw Exception('Error al eliminar producto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // CATEGORÍAS

  // GET - Obtener todas las categorías
  Future<List<Categoria>> getCategorias() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/categorias'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((json) => Categoria.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar categorías: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // POST - Crear nueva categoría
  Future<Categoria> createCategoria(Categoria categoria) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/categorias'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(categoria.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Categoria.fromJson(jsonResponse);
      } else {
        throw Exception('Error al crear categoría: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // PUT - Actualizar categoría
  Future<Categoria> updateCategoria(Categoria categoria) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl/categorias/${categoria.idCategoria}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(categoria.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Categoria.fromJson(jsonResponse);
      } else {
        throw Exception(
          'Error al actualizar categoría: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // DELETE - Eliminar categoría
  Future<void> deleteCategoria(int id) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/categorias/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Error al eliminar categoría: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
