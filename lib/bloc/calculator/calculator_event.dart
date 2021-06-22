part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent {}

class ResetAC extends CalculatorEvent {}

class AddNumber extends CalculatorEvent {
  final String number;
  AddNumber(this.number);
}

class ChangeNegativePositive extends CalculatorEvent {}

class DeleteLastEntry extends CalculatorEvent {}

class OperationEntry extends CalculatorEvent {
  OperationEntry(this.operation);
  final String operation;
}

class CalculateResult extends CalculatorEvent {}
