abstract class CartEvent {}

class AddToCartsEvent extends CartEvent {
  final int productId;
  final String customerId;

  AddToCartsEvent(this.productId, this.customerId);
}

class LoadCartsEvent extends CartEvent {
  final String customerId;
  LoadCartsEvent(this.customerId);
}

