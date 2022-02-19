import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../consts/constants.dart';
import '../../../providers/Oders.dart' as ord;
import '../../../widgets/neumorphics/neumorphic_card.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({
    Key? key,
    required this.order,
  }) : super(key: key);

  final ord.OrderItem order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return NeumorphicCard(
      shadowBlur: 10,
      borderRadius: BorderRadius.circular(10),
      backgroundColor: kBackgroundColor,
      child: Column(
        children: [
          ListTile(
            title: Text(
              '${widget.order.amount}\$',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height:
                _expanded ? (widget.order.products.length * 50.0 + 10.0) : 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 25,
                  headingRowHeight: 20,
                  horizontalMargin: 0,
                  columns: const [
                    DataColumn(label: Text('Product')),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('Q\'ty')),
                    DataColumn(label: Text('Total')),
                  ],
                  rows: [
                    ...widget.order.products
                        .map((product) => DataRow(cells: [
                              DataCell(Text(product.title)),
                              DataCell(Text('\$${product.price}')),
                              DataCell(Text('${product.quantity}')),
                              DataCell(Text(
                                '\$${product.price * product.quantity}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                            ]))
                        .toList()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
