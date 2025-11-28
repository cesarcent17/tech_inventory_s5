import 'package:flutter/material.dart';
import '../models/tecnologia.dart';
import '../services/tecnologia_service.dart';

class TechFormPage extends StatefulWidget {
  final Tecnologia? item;

  TechFormPage({this.item});

  @override
  _TechFormPageState createState() => _TechFormPageState();
}

class _TechFormPageState extends State<TechFormPage> {
  final _formKey = GlobalKey<FormState>();
  final service = TecnologiaService();

  late TextEditingController tipoCtrl;
  late TextEditingController marcaCtrl;
  late TextEditingController modeloCtrl;
  late TextEditingController serieCtrl;
  late TextEditingController estadoCtrl;

  @override
  void initState() {
    super.initState();

    tipoCtrl = TextEditingController(text: widget.item?.tipo ?? "");
    marcaCtrl = TextEditingController(text: widget.item?.marca ?? "");
    modeloCtrl = TextEditingController(text: widget.item?.modelo ?? "");
    serieCtrl = TextEditingController(text: widget.item?.serie ?? "");
    estadoCtrl = TextEditingController(text: widget.item?.estado ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? "Nuevo Equipo" : "Editar Equipo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              campo("Tipo", tipoCtrl),
              campo("Marca", marcaCtrl),
              campo("Modelo", modeloCtrl),
              campo("Serie", serieCtrl),
              campo("Estado", estadoCtrl),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Guardar"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final item = Tecnologia(
                      id: widget.item?.id,
                      tipo: tipoCtrl.text,
                      marca: marcaCtrl.text,
                      modelo: modeloCtrl.text,
                      serie: serieCtrl.text,
                      estado: estadoCtrl.text,
                      fechaIngreso: DateTime.now(),
                    );

                    if (widget.item == null) {
                      service.create(item);
                    } else {
                      service.update(item);
                    }

                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget campo(String label, TextEditingController ctrl) {
    return TextFormField(
      controller: ctrl,
      decoration: InputDecoration(labelText: label),
      validator: (v) => v!.isEmpty ? "Campo requerido" : null,
    );
  }
}
