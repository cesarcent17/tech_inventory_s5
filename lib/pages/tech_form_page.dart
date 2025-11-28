import 'package:flutter/material.dart';
import '../models/tecnologia.dart';
import '../services/tecnologia_service.dart';

class TechFormPage extends StatefulWidget {
  final Tecnologia? item;

  const TechFormPage({super.key, this.item});

  @override
  State<TechFormPage> createState() => _TechFormPageState();
}

class _TechFormPageState extends State<TechFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TecnologiaService service = TecnologiaService();

  late TextEditingController tipo;
  late TextEditingController marca;
  late TextEditingController modelo;
  late TextEditingController estado;
  late TextEditingController serie;

  late String fechaIngreso; // AUTOMÁTICA

  @override
  void initState() {
    super.initState();
    final item = widget.item;

    tipo = TextEditingController(text: item?.tipo ?? "");
    marca = TextEditingController(text: item?.marca ?? "");
    modelo = TextEditingController(text: item?.modelo ?? "");
    estado = TextEditingController(text: item?.estado ?? "");
    serie = TextEditingController(text: item?.serie ?? "");

    // FECHA AUTOMÁTICA
    fechaIngreso = item?.fechaIngreso ?? DateTime.now().toIso8601String();
  }

  Future<void> guardar() async {
    if (_formKey.currentState!.validate()) {
      final t = Tecnologia(
        id: widget.item?.id,
        tipo: tipo.text,
        marca: marca.text,
        modelo: modelo.text,
        estado: estado.text,
        serie: serie.text,
        fechaIngreso: fechaIngreso, // AUTOMÁTICA
      );

      if (widget.item == null) {
        await service.create(t);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registro creado")),
        );
      } else {
        await service.update(t);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registro actualizado")),
        );
      }

      Navigator.pop(context);
    }
  }

  Widget campo(String texto, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: texto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (v) =>
            v == null || v.isEmpty ? "Este campo es obligatorio" : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final azulUisrael = const Color(0xFF004DA8);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: azulUisrael,
        title: Text(
          widget.item == null
              ? "Nuevo Registro"
              : "Editar Registro",
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              campo("Tipo", tipo),
              campo("Marca", marca),
              campo("Modelo", modelo),
              campo("Estado", estado),
              campo("Serie", serie),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: azulUisrael,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: guardar,
                child: const Text(
                  "Guardar",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
