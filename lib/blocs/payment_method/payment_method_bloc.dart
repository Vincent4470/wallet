import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wallet/models/payment_method_model.dart';
import 'package:wallet/services/payment_method_service.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  PaymentMethodBloc() : super(PaymentMethodInitial()) {
    on<PaymentMethodEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is PaymentMethodGet) {
        try {
          emit(PaymentMethodLoading());
          final paymentMethods =
              await PaymentMethodService().getPaymentMethods();
          emit(PaymentMethodSuccess(paymentMethods));
        } catch (e) {
          emit(PaymentMethodFailed(e.toString()));
        }
      }
    });
  }
}
