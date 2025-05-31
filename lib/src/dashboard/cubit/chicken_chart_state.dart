part of 'chicken_chart_cubit.dart';

@immutable
abstract class ChickenChartState {}

class ChickenChartInitial extends ChickenChartState {}

class ChickenChartLoading extends ChickenChartState {}

class ChickenChartLoaded extends ChickenChartState {
  final ChickenChartModel model;
  final String selectedDateRange;


 ChickenChartLoaded({required this.model, required this.selectedDateRange});
}

class ChickenChartError extends ChickenChartState {
  final String message;
   ChickenChartError({required this.message});
}
