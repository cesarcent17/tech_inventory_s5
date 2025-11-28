import 'package:flutter/material.dart';
import '../models/tecnologia.dart';
import '../services/tecnologia_service.dart';
import 'tech_form_page.dart';

class TechListPage extends StatefulWidget {
  const TechListPage({super.key});

  @override
  State<TechListPage> createState() => _TechListPageState();
}

class _TechListPageState extends State<TechListPage> {
  final TecnologiaService service = TecnologiaService();
  List<Tecnologia> lista = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    setState(() => loading = true);
    lista = await service.getAll();
    setState(() => loading = false);
  }

  Future<void> confirmarEliminar(String id) async {
    final confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirmar"),
        content: const Text("¿Estás seguro de eliminar este registro?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar")),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Eliminar")),
        ],
      ),
    );

    if (confirm == true) {
      await service.delete(id);
      cargarDatos();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registro eliminado")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "UISRAEL – César Centurión 7A",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF004DA8),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
floatingActionButton: FloatingActionButton(
  backgroundColor: const Color(0xFF004DA8),
  child: const Icon(Icons.add, color: Colors.white),
  onPressed: () async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TechFormPage()),
    );
    cargarDatos();
  },
),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : lista.isEmpty
              ? const Center(child: Text("Sin datos registrados"))
              : ListView.builder(
                  itemCount: lista.length,
                  itemBuilder: (_, i) {
                    final item = lista[i];
                    return Card(
                      child: ListTile(
                        title: Text("${item.tipo} - ${item.marca}"),
                        subtitle: Text("Modelo: ${item.modelo}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => confirmarEliminar(item.id!),
                        ),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TechFormPage(item: item)),
                          );
                          cargarDatos();
                        },
                      ),
                    );
                  }),
    );
  }
}
