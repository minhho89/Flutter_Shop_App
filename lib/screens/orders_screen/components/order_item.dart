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
            title: Text('${widget.order.amount}\$'),
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
                _expanded ? (widget.order.products.length * 20.0 + 10.0) : 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                children: widget.order.products
                    .map((product) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Text(
                                product.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .fontSize,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                    ),
                                    width: 80,
                                    child: Text('\$${product.price}')),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text('x${product.quantity}'),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('='),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('${product.price * product.quantity}'),
                              ],
                            ),
                          ],
                        ))
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
