import 'dart:async';

import 'package:ioi_barcode_scanner/model/userPermissions/companyList_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ioi_barcode_scanner/bloc_login/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'drawers_event.dart';
part 'drawers_state.dart';

class AppsBloc extends Bloc<AppsEvent, AppsState> {
  final UserRepository userRepository;

  AppsBloc({
    @required this.userRepository});

  @override
  AppsState get initialState => AppsInitial();

  @override
  Stream<AppsState> mapEventToState(
      AppsEvent event,
      ) async* {
    final currentState = state;
    List<String> companiesNamesList;
    List<String> appList;
    List<String> servicesList;
    try {
    if (event is FetchAppsFromLocalDB) {
      yield AppsInitial();
      try {
         appList  = await userRepository.getAppsList();
      } catch (error) {
        yield AppsFailure(error: error.toString());
      }
      if(appList == null){
        yield AppsUnavailableForUser();
      } else {
        yield AppsSuccess(apps: appList);
      }
    }

    if (event is FetchServicesFromDB) {
      yield ServicesInitial();
      try {
        servicesList  = await userRepository.getServicesList();
      } catch (error) {
        yield ServicesFailure(error: error.toString());
      }
      yield ServicesSuccess(services: servicesList);
    }

      if (event is FetchCompaniesNamesFromDB) {
        yield CompanyInitial();

        bool doIHaveCompanyDetailsInMyLocalDB =
        await userRepository.checkForLocalCompanies();

        if (!doIHaveCompanyDetailsInMyLocalDB) {
          int howManyComs = await userRepository.howManyCompany();
          String token = await userRepository.getTokenFromDB();
          for (int i = 1; i <= howManyComs; i++) {
            int companyID = await userRepository.getCompanyIDFromDB(i);
            CompanyDetails companyDetails = await userRepository
                .authCompanyDetails(token: token, id: companyID);
            await userRepository.persistCompanyDetails(
                companyDetails: companyDetails);
          }

          //final companies = await _fetchCompanies();
          companiesNamesList = await userRepository.getCompaniesNames();

          yield CompaniesNamesSuccess(companiesNames: companiesNamesList);
        } else {
          //final companies = await _fetchCompanies();
          companiesNamesList = await userRepository.getCompaniesNames();

          yield CompaniesNamesSuccess(companiesNames: companiesNamesList);
        }
      }
    } catch (error) {
      yield CompanyFailure(error: error.toString());
    }

  }


  Future<List<CompanyDetails>> _fetchCompanies() async {
    var xx = await userRepository.getCompanies();

    return xx.map<CompanyDetails>((rawPost) {
      return CompanyDetails(
        companyId: rawPost['companyId'],
        companyName: rawPost['companyName'],
        host: rawPost['host'],
      );
    }).toList();
  }
}