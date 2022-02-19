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
      ),
    );
  }
}
