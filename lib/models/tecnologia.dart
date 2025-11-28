class Tecnologia {
  String? id;
  String tipo;
  String marca;
  String modelo;
  String serie;
  String estado;
  DateTime fechaIngreso;

  Tecnologia({
    this.id,
    required this.tipo,
    required this.marca,
    required this.modelo,
    required this.serie,
    required this.estado,
    required this.fechaIngreso,
  });

  Map<String, dynamic> toMap() => {
        "tipo": tipo,
        "marca": marca,
        "modelo": modelo,
        "serie": serie,
        "estado": estado,
        "fechaIngreso": fechaIngreso.toIso8601String(),
      };

  factory Tecnologia.fromMap(String id, Map<String, dynamic> map) {
    return Tecnologia(
      id: id,
      tipo: map["tipo"],
      marca: map["marca"],
      modelo: map["modelo"],
      serie: map["serie"],
      estado: map["estado"],
      fechaIngreso: DateTime.parse(map["fechaIngreso"]),
    );
  }
}
