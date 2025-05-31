part of 'dashboard_cubit.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class DashboardOnLoading extends DashboardState {}

final class DashboardOnSuccess extends DashboardState {}

final class DashboardOnLocationChanged extends DashboardState {}

// class DashboardGlobalModelUpdated extends DashboardState {
//   DashboardGlobalModelUpdated({required this.globalModel});


//   @override
//   List<Object> get props => [globalModel];
// }

// final class DashboardSuccessBatchLocation extends DashboardState {
//   const DashboardSuccessBatchLocation({ required this.batchList, required this.locationList });

//   final List<Datum> batchList;
//   final List<LocationModel> locationList;
//   final GlobalModel globalModel;

//   @override
//   List<Object> get props => [batchList, locationList, globalModel];
// }

final class DashboardMenuSuccess extends DashboardState {
  const DashboardMenuSuccess({
    required this.menuList,
  });

  final List<MenuItem> menuList;

  @override
  List<Object> get props => [menuList];
}

final class DashboardOnFailed extends DashboardState {
  const DashboardOnFailed({required this.message});
  final String message;

  @override
  List<Object> get props => ["message: $message"];
}

final class DashboardOnError extends DashboardState {
  const DashboardOnError({required this.model});
  final AppReportModel model;

  @override
  List<Object> get props => ["model: $model"];
}
