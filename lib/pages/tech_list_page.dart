import 'package:flutter/material.dart';
import '../services/tecnologia_service.dart';
import '../models/tecnologia.dart';
import 'tech_form_page.dart';

class TechListPage extends StatelessWidget {
  final TecnologiaService service = TecnologiaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inventario Tecnología — César Centurión 7A")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => TechFormPage()));
        },
      ),
      body: StreamBuilder<List<Tecnologia>>(
        stream: service.getAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final items = snapshot.data!;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) {
              final item = items[i];
              return ListTile(
                title: Text("${item.tipo} - ${item.marca}"),
                subtitle: Text(item.modelo),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _confirmDelete(context, item.id!);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TechFormPage(item: item),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          "Confirmación",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text("¿Estás seguro de que deseas eliminar este registro?"),
        actions: [
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text("Eliminar"),
            onPressed: () async {
              await TecnologiaService().delete(id);
              Navigator.of(context).pop(); // cerrar el popup
            },
          ),
        ],
      );
    },
  );
}

}
