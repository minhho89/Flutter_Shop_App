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
      child: ListTile(
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
    );
  }
}
