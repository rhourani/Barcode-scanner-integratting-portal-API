part of 'drawers_bloc.dart';

abstract class AppsEvent extends Equatable {
  const AppsEvent();

  @override
  List<Object> get props => [];
  List<Object> get companyDetailsProps => [];
}

class FetchAppsFromLocalDB extends AppsEvent {
  const FetchAppsFromLocalDB();

  @override
  List<Object> get props => [];
}

class FetchServicesFromDB extends AppsEvent {
  const FetchServicesFromDB();

  @override
  List<Object> get props => [];
}

class CompanyFetched extends AppsEvent {}

class FetchCompanyFromServer extends AppsEvent{
  final CompanyDetails companyDetails;

  FetchCompanyFromServer({@required this.companyDetails});

  @override
  List<Object> get props => [companyDetails];
}

class FetchCompaniesNamesFromDB extends AppsEvent{
  const FetchCompaniesNamesFromDB();

  @override
  List<Object> get props => [];
}
