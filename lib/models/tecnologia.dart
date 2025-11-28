class Tecnologia {
  String? id;
  String tipo;
  String marca;
  String modelo;
  String estado;
  String serie;
  String fechaIngreso;

  Tecnologia({
    this.id,
    required this.tipo,
    required this.marca,
    required this.modelo,
    required this.estado,
    required this.serie,
    required this.fechaIngreso,
  });

  Map<String, dynamic> toMap() => {
        "tipo": tipo,
        "marca": marca,
        "modelo": modelo,
        "estado": estado,
        "serie": serie,
        "fechaIngreso": fechaIngreso,
      };

  factory Tecnologia.fromMap(String id, Map<String, dynamic> map) {
    return Tecnologia(
      id: id,
      tipo: map["tipo"] ?? "",
      marca: map["marca"] ?? "",
      modelo: map["modelo"] ?? "",
      estado: map["estado"] ?? "",
      serie: map["serie"] ?? "",
      fechaIngreso: map["fechaIngreso"] ?? "",
    );
  }
}
