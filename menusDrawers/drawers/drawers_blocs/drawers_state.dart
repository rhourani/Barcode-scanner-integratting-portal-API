part of 'drawers_bloc.dart';

abstract class AppsState extends Equatable {
  const AppsState();

  @override
  List<Object> get props => [];
}

class AppsInitial extends AppsState {}

class AppsLoading extends AppsState {}

class AppsUnavailableForUser extends AppsState {}

class AppsHasBeenRetrivedFromServerToLocalDb extends AppsState {}

class AppsFailure extends AppsState {
  final String error;
  const AppsFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' AppsFailure { error: $error }';
}

class AppsSuccess extends AppsState {
  final List<String> apps; // List<Company>

  const AppsSuccess({
    this.apps,
  });

  AppsSuccess copyWith({
    List<String> apps,
  }) {
    return AppsSuccess(
      apps: apps ?? this.apps,
    );
  }

  @override
  List<Object> get props => [apps];

  @override
  String toString() =>
      'AppsSuccess { apps: ${apps.length}}';
}





/*
* This handles the services of the app states
* */
class ServicesInitial extends AppsState {}

class ServicesLoading extends AppsState {}

class ServicesHasBeenRetrivedFromServerToLocalDb extends AppsState {}

class ServicesFailure extends AppsState {
  final String error;
  const ServicesFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' ServicesFailure { error: $error }';
}

class ServicesSuccess extends AppsState {
  final List<String> services; // List<Company>

  const ServicesSuccess({
    this.services,
  });

  ServicesSuccess copyWith({
    List<String> services,
  }) {
    return ServicesSuccess(
      services: services ?? this.services,
    );
  }

  @override
  List<Object> get props => [services];

  @override
  String toString() =>
      'ServicesSuccess { services: ${services.length}}';
}





/*
* This handles the companies of the user states
* */
class CompanyInitial extends AppsState {}

class CompanyLoading extends AppsState {}
class CompanyHasBeenRetrivedFromServerToLocalDb extends AppsState {}

class CompanyFailure extends AppsState {
  final String error;
  CompanyFailure({@required this.error});
}

class CompanySuccess extends AppsState {
  final List<CompanyDetails> companies; // List<Company>

  const CompanySuccess({
    this.companies,
  });

  CompanySuccess copyWith({
    List<CompanyDetails> companies,
  }) {
    return CompanySuccess(
      companies: companies ?? this.companies,
    );
  }

  @override
  List<Object> get props => [companies];

  @override
  String toString() =>
      'CompanySuccess { companies: ${companies.length}}';


}

class CompaniesNamesSuccess extends AppsState {
  final List<String> companiesNames;

  const CompaniesNamesSuccess({
    this.companiesNames,
  });

  CompaniesNamesSuccess copyWith({
    List<String> services,
  }) {
    return CompaniesNamesSuccess(
      companiesNames: companiesNames ?? this.companiesNames,
    );
  }

  @override
  List<Object> get props => [companiesNames];

  @override
  String toString() =>
      'CompaniesNamesSuccess { companiesNames: ${companiesNames.length}}';
}
