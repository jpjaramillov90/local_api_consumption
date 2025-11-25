class Categoria {
  final int idCategoria;
  final String nombreCategoria;

  Categoria({required this.idCategoria, required this.nombreCategoria});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      idCategoria: json['idCategoria'] ?? 0,
      nombreCategoria: json['nombreCategoria'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'idCategoria': idCategoria, 'nombreCategoria': nombreCategoria};
  }

  Categoria copyWith({int? idCategoria, String? nombreCategoria}) {
    return Categoria(
      idCategoria: idCategoria ?? this.idCategoria,
      nombreCategoria: nombreCategoria ?? this.nombreCategoria,
    );
  }

  @override
  String toString() {
    return nombreCategoria;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Categoria && other.idCategoria == idCategoria;
  }

  @override
  int get hashCode => idCategoria.hashCode;
}
