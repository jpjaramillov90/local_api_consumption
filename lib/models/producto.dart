class Producto {
  final int idProducto;
  final String? codigoBarra;
  final String nombre;
  final int? idCategoriaProductos;
  final String? categoriaNombre;
  final String? marca;
  final double precio;

  Producto({
    required this.idProducto,
    this.codigoBarra,
    required this.nombre,
    this.idCategoriaProductos,
    this.categoriaNombre,
    this.marca,
    required this.precio,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      idProducto: json['IdProducto'] ?? 0,
      codigoBarra: json['CodigoBarra'],
      nombre: json['Nombre'] ?? '',
      idCategoriaProductos: json['idCategoriaProductos'],
      categoriaNombre: json['categoriaNombre'],
      marca: json['Marca'],
      precio: double.tryParse(json['Precio']?.toString() ?? '0') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CodigoBarra': codigoBarra,
      'Nombre': nombre,
      'idCategoriaProductos': idCategoriaProductos,
      'Marca': marca,
      'Precio': precio,
    };
  }

  Producto copyWith({
    int? idProducto,
    String? codigoBarra,
    String? nombre,
    int? idCategoriaProductos,
    String? categoriaNombre,
    String? marca,
    double? precio,
  }) {
    return Producto(
      idProducto: idProducto ?? this.idProducto,
      codigoBarra: codigoBarra ?? this.codigoBarra,
      nombre: nombre ?? this.nombre,
      idCategoriaProductos: idCategoriaProductos ?? this.idCategoriaProductos,
      categoriaNombre: categoriaNombre ?? this.categoriaNombre,
      marca: marca ?? this.marca,
      precio: precio ?? this.precio,
    );
  }
}
