import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/pages/orders/bloc/OrderBloc.dart';
import 'package:e_commerce/pages/orders/bloc/OrderEvent.dart';
import 'package:e_commerce/common/entities/OrderRequestEntity.dart';
import 'package:e_commerce/common/entities/ProductRequest.dart';

import '../order_bottom_sheet.dart';

class OrderBottomSheet extends StatefulWidget {
  final int productId;
  final String customerId;
  final double productPrice;

  OrderBottomSheet({required this.productId, required this.customerId, required this.productPrice});

  @override
  _OrderBottomSheetState createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _paymentMethodController = TextEditingController();

  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTextFieldOrder("quantity", "Quantity", controller: _quantityController),
              buildTextFieldOrder("card", "Payment Method", controller: _paymentMethodController),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Total Amount: ${widget.productPrice}'),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(

                onPressed: () {
                  setState(() {
                    _errorMessage = null; // Clear previous error message
                  });

                  try {
                    String quantityText = _quantityController.text.trim();
                    print('Quantity entered: "$quantityText"');

                    double? quantity = double.tryParse(quantityText);

                    if (quantity == null) {
                      setState(() {
                        _errorMessage = 'Please enter a valid quantity';
                      });
                      return;
                    }

                    print('Parsed quantity: $quantity');

                    var orderRequest = OrderRequestEntity(
                      amount: widget.productPrice,
                      paymentMethod: _paymentMethodController.text,
                      customerId: widget.customerId,
                      products: [
                        ProductRequest(
                          productId: widget.productId,
                          quantity: quantity,
                        ),
                      ],
                    );

                    BlocProvider.of<OrderBloc>(context).add(AddOrderEvent(orderRequest));
                  } catch (e) {
                    print('Failed to parse quantity. Error: $e');
                  }
                },
                child: Text('Complete Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}