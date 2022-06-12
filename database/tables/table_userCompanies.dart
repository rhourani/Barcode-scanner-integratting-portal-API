final userCompaniesTableDB = 'userCompaniesTableDB';

//UserCompanies Table fields
final id = "id";
final companyID = "companyID";
final companyName = "companyName";
final companyHost = "companyHost";
final groupName = "groupName";
final permissions = "permissions";


String createUserCompaniesTableDB = "CREATE TABLE IF NOT EXISTS $userCompaniesTableDB ("
    "$id INTEGER PRIMARY KEY, "
    "$companyID INTEGER, "
    "$groupName TEXT, "
    "$permissions TEXT "
    ")";
