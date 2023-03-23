enum PaymentStatus {
  pending('pending'),
  paid('paid'),
  failed('payment_failed'),
  succeeded('succeeded'),
  cancelled('cancelled'),
  requiresPaymentMethod('requires_payment_method'),
  inProgress('in_progress'),
  unknown('unknown');

  final String value;

  const PaymentStatus(this.value);
}
