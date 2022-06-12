import 'package:ioi_barcode_scanner/bloc_login/api_connections/api_token_connection.dart';
import 'package:ioi_barcode_scanner/bloc_login/dao/user_dao.dart';
import 'package:ioi_barcode_scanner/menusDrawers/api_connections/api_user_permissions.dart';
import 'package:ioi_barcode_scanner/model/userAccount/userLoginDetailsModel.dart';
import 'package:ioi_barcode_scanner/model/userAccount/user_login_model.dart';
import 'package:ioi_barcode_scanner/model/userPermissions/companyList_model.dart';
import 'package:ioi_barcode_scanner/model/userPermissions/user_permissions.dart';
import 'package:meta/meta.dart';

class UserRepository {
  final userDao = UserDao();

  Future<UserLoginDetails> authenticate({
    @required String email,
    @required String password,
  }) async {
    UserLogin userLogin = UserLogin(email: email, password: password);
    UserLoginDetails userToken = await getToken(userLogin);
    return userToken;
  }

  //TODO Try to connect to the api from here by calling userpermissions
  Future<UserPermissions> authPermissions({@required String token}) async {
    UserPermissions userPermissions = await getUserPermissions(token);
    return userPermissions;
  }

  Future<CompanyDetails> authCompanyDetails(
      {@required String token, @required int id}) async {
    CompanyDetails companyDetails = await getCompanyDetails(id, token);
    return companyDetails;
  }

  Future<void> persistToken({@required UserLoginDetails user}) async {
    // write token with the user to the database
    await userDao.createUser(user);
  }

  Future<void> persistPermissions({
    @required UserPermissions userPermissions,
  }) async {
    // write Permissions with the user to the database
    await userDao.createUserPermissions(userPermissions);
  }

  Future<void> persistCompanyDetails({
    @required CompanyDetails companyDetails,
  }) async {
    // write company details with the user to the database
    await userDao.createUserCompanyDetails(companyDetails);
  }

  Future<void> deleteToken({@required int id}) async {
    await userDao.deleteUser(id);
  }

  Future<void> dropDB() async {
    await userDao.dropUserDB();
  }

  Future<bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }

  Future<String> getTokenFromDB() async {
    String result = await userDao.getUserTokenFromDb();
    return result;
  }

  Future<int> howManyCompany() async {
    int result = await userDao.howManyCompanyDAO();
    return result;
  }

  Future<bool> checkForLocalCompanies() async {
    bool result = await userDao.checkForLocalCompaniesDAO();
    return result;
  }

  Future<int> getCompanyIDFromDB(int rowNumber) async {
    int _rowNumber = rowNumber;
    int result = await userDao.getDAOCompanyIDFromDb(_rowNumber);
    return result;
  }

  Future<dynamic> getCompanies() async {
    var result = await userDao.getCompanyDetails();
    return result;
  }

  Future <List<String>> getAppsList() async {
    List<String> result = await userDao.getAppsPermissionsForUser();
    return result;
  }

  Future <List<String>> getServicesList() async {
    List<String> result = await userDao.getServicesPermissionsForUser();
    return result;
  }

  Future <List<String>> getCompaniesNames() async {
    List<String> result = await userDao.getUserCompaniesNames();
    return result;
  }

  /*
  * Settings: Change Password
  * */
  Future<bool> changeUserPassword({
    @required String oldPassword,
    @required String newPassword,
    @required String token,
  }) async {
    bool resetPassword = await changePassword(oldPassword, newPassword, token);
    return resetPassword;
  }

}
