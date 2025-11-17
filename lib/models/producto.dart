class Producto {
  final int idProducto;
  final String? codigoBarra;
  final String nombre;
  final String? categoria;
  final String? marca;
  final double precio;

  Producto({
    required this.idProducto,
    this.codigoBarra,
    required this.nombre,
    this.categoria,
    this.marca,
    required this.precio,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      idProducto: json['IdProducto'] ?? 0,
      codigoBarra: json['CodigoBarra'],
      nombre: json['Nombre'] ?? '',
      categoria: json['Categoria'],
      marca: json['Marca'],
      precio: double.tryParse(json['Precio']?.toString() ?? '0') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CodigoBarra': codigoBarra,
      'Nombre': nombre,
      'Categoria': categoria,
      'Marca': marca,
      'Precio': precio,
    };
  }

  Producto copyWith({
    int? idProducto,
    String? codigoBarra,
    String? nombre,
    String? categoria,
    String? marca,
    double? precio,
  }) {
    return Producto(
      idProducto: idProducto ?? this.idProducto,
      codigoBarra: codigoBarra ?? this.codigoBarra,
      nombre: nombre ?? this.nombre,
      categoria: categoria ?? this.categoria,
      marca: marca ?? this.marca,
      precio: precio ?? this.precio,
    );
  }
}
