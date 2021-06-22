import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorState());

  @override
  Stream<CalculatorState> mapEventToState(
    CalculatorEvent event,
  ) async* {
    // Borrar todo
    if (event is ResetAC) {
      // aca no use el this.
      yield* _resetAC();
      // Agregar numeros
    } else if (event is AddNumber) {
      yield state.copyWith(
        mathResult: (state.mathResult == '0' && event.number != '.')
            // que no se repitan los puntos
            ? event.number
            : state.mathResult + event.number,
      );
      // Cambiar -/+
    } else if (event is ChangeNegativePositive) {
      yield state.copyWith(
          mathResult: (state.mathResult.contains('-')
              ? state.mathResult.replaceFirst('-', '')
              : '-' + state.mathResult));
      // Borrar ultimo digito
    } else if (event is DeleteLastEntry) {
      yield state.copyWith(
          mathResult: state.mathResult.length > 1
              ? state.mathResult.substring(0, state.mathResult.length - 1)
              // Terminar logica de el punto .
              : '0');
      // Agreagar operacion
    } else if (event is OperationEntry) {
      yield state.copyWith(
        firstNumber: state.mathResult,
        mathResult: '0',
        operation: event.operation,
        secondNumber: '0',
      );
      // Calcular Resultado
    } else if (event is CalculateResult) {
      yield* _calculateResult();
    }
  }

  Stream<CalculatorState> _resetAC() async* {
    yield CalculatorState(
      firstNumber: '0',
      operation: '+',
      secondNumber: '0',
      mathResult: '0',
    );
  }

  Stream<CalculatorState> _calculateResult() async* {
    final double num1 = double.parse(state.firstNumber);
    final double num2 = double.parse(state.mathResult);

    switch (state.operation) {
      case '+':
        yield state.copyWith(
          secondNumber: state.mathResult,
          mathResult: '${num1 + num2}',
        );

        break;

      default:
        yield state;
    }
  }
}
