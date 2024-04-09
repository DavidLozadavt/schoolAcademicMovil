import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:vtschool/src/config/theme/app_theme.dart';

class PagosPage extends StatefulWidget {
  const PagosPage({Key? key}) : super(key: key);

  @override
  _PagosPageState createState() => _PagosPageState();
}

class _PagosPageState extends State<PagosPage> {
  final Map<String, Map<String, dynamic>> _selectedProducts = {
    'Carnet': {'selected': false, 'price': 10000},
    'Comida': {'selected': false, 'price': 20000},
    'Material': {'selected': false, 'price': 1000},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  listColor[14],
                  listColor[11],
                ],
              ),
            ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Pagos Pendientes',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  color: listColor[2],
                  border: Border.all(
                      color: listColor[1]),
                      borderRadius: BorderRadius.circular(20)
                ),
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Producto',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Precio',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Seleccionar',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                  rows: _selectedProducts.keys.map((String producto) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(producto),
                        ),
                        DataCell(
                          Text(
                              '\$${_selectedProducts[producto]!['price']} COP'), // Mostrar el precio dinámicamente
                        ),
                        DataCell(
                          Checkbox(
                            value: _selectedProducts[producto]!['selected'],
                            onChanged: (bool? value) {
                              setState(() {
                                _selectedProducts[producto]!['selected'] = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  double total = 0;
                  _selectedProducts.forEach((producto, detalles) {
                    if (detalles['selected']) {
                      total += detalles['price'];
                    }
                  });
        
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Total a pagar'),
                        content:
                            Text('El total seleccionado es: ${total.toString()}'),
                        actions: [
                          TextButton(
                            onPressed: () {
                            Get.toNamed('/creditCart');
                            },
                            child: const Text('Ir a pagar'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cerrar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Calcular Total'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
