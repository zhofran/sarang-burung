part of 'financial_cubit.dart';

sealed class FinancialState extends Equatable {
  const FinancialState();

  @override
  List<Object> get props => [];
}

final class FinancialInitial extends FinancialState {}

class FinancialLoading extends FinancialState {}

class FinancialSuccess extends FinancialState {}

class FinancialLoaded extends FinancialState {
  final FinancialModel models;

 const FinancialLoaded({required this.models});

  @override
  List<Object> get props => [models];
}

class FinancialError extends FinancialState {
  final String message;
   const FinancialError({required this.message});
}