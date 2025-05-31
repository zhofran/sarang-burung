part of 'report_cubit.dart';

sealed class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

final class ReportInitial extends ReportState {}

final class ReportLoading extends ReportState {}

final class ReportSuccess extends ReportState {}

final class ReportSuccessWeight extends ReportState {
  const ReportSuccessWeight({required this.eggWeight});

  final double eggWeight;

  @override
  List<Object> get props => [eggWeight];
}

final class ReportFailed extends ReportState {
  const ReportFailed({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

final class ReportSuccessData extends ReportState {
  const ReportSuccessData({required this.totalEggsWeight});

  final double totalEggsWeight;
  
  @override
  List<Object> get props => [totalEggsWeight];
}

final class ReportPanen extends ReportState {
  const ReportPanen({required this.panenDataTelur});

  final List<PanenTelurModel> panenDataTelur;
  
  @override
  List<Object> get props => [panenDataTelur];
}

final class ReportError extends ReportState {
  const ReportError({required this.model});
  final AppReportModel model;

  @override
  List<Object> get props => ["model: $model"];
}
